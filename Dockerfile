# 构建阶段：用debian系的slim镜像（GitHub CI最稳定）
FROM node:18-slim AS builder
WORKDIR /app
ENV TZ=UTC \
    # 直接用环境变量配置npm，避开所有config命令
    NPM_CONFIG_REGISTRY=https://registry.npmjs.org \
    NPM_CONFIG_UNSAFE_PERM=true \
    NPM_CONFIG_STRICT_SSL=false

# 安装debian系构建依赖（GitHub CI无兼容性问题）
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    make \
    g++ \
    git \
    curl \
    && ln -sf python3 /usr/bin/python \
    # 清理apt缓存，减小镜像体积
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 先验证npm+网络（提前暴露问题）
RUN node -v && npm -v && curl -I https://registry.npmjs.org/npm

# 缓存依赖（极简命令，无任何多余参数）
COPY package.json package-lock.json ./
# 仅保留最核心参数，避免任何兼容性问题
RUN npm install --no-fund --no-audit

# 构建项目
COPY . .
RUN npm run build && rm -rf node_modules

# 运行阶段：同样用slim镜像（和构建阶段一致）
FROM node:18-slim AS runner
WORKDIR /app
ENV TZ=UTC \
    NODE_ENV=production \
    NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000

# 创建非root用户（符合GitHub安全规范）
RUN groupadd --system --gid 1001 nodejs && \
    useradd --system --uid 1001 --gid nodejs nuxt && \
    chown -R nuxt:nodejs /app
USER nuxt

# 复制构建产物
COPY --from=builder /app/.output ./.output

# 暴露端口
EXPOSE 3000

# 极简健康检查（仅用node内置模块）
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD node -e "try { \
        const req = require('http').request({host:'localhost',port:3000,path:'/_health'}, (res) => process.exit(res.statusCode===200?0:1)); \
        req.on('error', () => process.exit(1)); \
        req.end(); \
    } catch (e) { process.exit(1); }"

# 启动命令
CMD ["node", ".output/server/index.mjs"]