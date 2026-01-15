# 构建阶段（GitHub Actions海外环境）
FROM node:18-alpine AS builder
WORKDIR /app
# 关键：用环境变量直接设置npm源（绕过npm config命令）
ENV TZ=UTC \
    NPM_CONFIG_REGISTRY=https://registry.npmjs.org \
    NPM_CONFIG_UNSAFE_PERM=true \
    NPM_CONFIG_STRICT_SSL=false \
    NPM_CONFIG_CACHE=/tmp/npm-cache

# 第一步：先验证npm环境（排查核心问题）
RUN node -v && npm -v \
    # 安装构建依赖（确保基础环境完整）
    && apk add --no-cache python3 make g++ git curl \
    && ln -sf python3 /usr/bin/python \
    # 测试npm源连通性（GitHub Actions海外必通）
    && curl -I https://registry.npmjs.org/npm

# 缓存依赖（极简命令，避免任何多余参数）
COPY package.json package-lock.json ./
# 用--registry直接指定源，彻底绕过config问题
RUN npm install --no-fund --no-audit --registry=https://registry.npmjs.org

# 构建项目（仅执行核心命令）
COPY . .
RUN npm run build && rm -rf node_modules /tmp/npm-cache

# 运行阶段（海外宝塔服务器）
FROM node:18-alpine AS runner
WORKDIR /app
ENV TZ=UTC \
    NODE_ENV=production \
    NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000

# 创建非root用户
RUN addgroup -g 1001 -S nodejs && adduser -S nuxt -u 1001 -G nodejs
RUN chown -R nuxt:nodejs /app
USER nuxt

# 复制产物
COPY --from=builder /app/.output ./.output

# 暴露端口
EXPOSE 3000

# 健康检查（极简版，避免依赖缺失）
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD node -e "try { require('http').get('http://localhost:3000/_health', (res) => process.exit(res.statusCode === 200 ? 0 : 1)); } catch (e) { process.exit(1); }"

# 启动命令
CMD ["node", ".output/server/index.mjs"]