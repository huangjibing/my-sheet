# ========== 构建阶段（Builder）：适配GitHub CI的构建优化 ==========
FROM node:18-alpine AS builder

# 核心：设置时区（避免GitHub CI中时间相关构建问题）
ENV TZ=UTC

# 设置工作目录，适配GitHub CI的权限模型
WORKDIR /app
# 放宽权限但限制范围，符合GitHub安全规范
RUN chmod 755 /app && \
    # 创建npm缓存目录并授权，避免权限冲突
    mkdir -p /tmp/npm-cache && chmod 777 /tmp/npm-cache

# 优化alpine源（GitHub CI海外环境，改用官方源更稳定）
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories

# 安装构建依赖（精简且适配GitHub CI）
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git \  # 新增：解决GitHub私有依赖拉取问题
    && ln -sf python3 /usr/bin/python

# 关键：GitHub专属npm配置优化
RUN npm config set registry https://registry.npmjs.org \
    && npm config set cache /tmp/npm-cache \
    && npm config set strict-ssl false \
    && npm config set unsafe-perm true \
    && npm config set fetch-retry-maxtimeout 60000 \  # 延长超时，适配GitHub网络波动
    && npm config set fetch-retry-mintimeout 10000 \
    # 禁用package-lock校验，避免GitHub CI中版本冲突
    && npm config set package-lock false

# 复制依赖文件（利用GitHub Actions的层缓存，核心优化）
# 先复制lock文件，最大化缓存命中率
COPY package.json package-lock.json* ./
# 针对GitHub CI的缓存策略：仅当依赖文件变化时重新install
RUN --mount=type=cache,target=/tmp/npm-cache,id=npm-builder,sharing=locked \
    npm install \
    --no-fund \
    --no-audit \
    --ignore-optional \
    --prefer-offline \  # 优先使用缓存，减少网络请求
    --no-progress \     # 减少GitHub Actions日志输出
    && rm -rf /tmp/npm-cache/_logs  # 清理日志，减小层体积

# 复制项目代码（最后复制，避免代码变动触发重新构建）
COPY . .

# 构建Nuxt3项目，适配GitHub CI的资源限制
RUN npm run build \
    # 构建完成后清理冗余文件，减小镜像体积
    && rm -rf node_modules .nuxt/cache .git

# ========== 运行阶段：GitHub生产级优化 ==========
FROM node:18-slim AS runner

# 设置时区，和构建阶段保持一致
ENV TZ=UTC
# 生产环境变量，适配GitHub容器部署
ENV NODE_ENV=production \
    NPM_CONFIG_UPDATE_NOTIFIER=false \
    # Nuxt3生产环境优化
    NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000

# 设置工作目录，创建非root用户（符合GitHub安全扫描要求）
WORKDIR /app
RUN groupadd --system --gid 1001 nodejs && \
    useradd --system --uid 1001 --gid nodejs --home /app nodejs && \
    chown -R nodejs:nodejs /app && \
    # 修复GitHub CI中slim镜像的DNS问题
    echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# 从构建阶段复制产物（仅复制必要文件，减小镜像体积）
COPY --from=builder --chown=nodejs:nodejs /app/.output ./.output
COPY --from=builder --chown=nodejs:nodejs /app/package.json ./package.json

# 切换到非root用户（GitHub镜像安全扫描强制要求）
USER nodejs

# 暴露端口（符合GitHub Actions容器规范）
EXPOSE 3000

# 增强健康检查（适配Nuxt3和GitHub容器健康校验）
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s --retries=3 \
    CMD node -e " \
        const http = require('http'); \
        const options = { hostname: 'localhost', port: 3000, path: '/_health', timeout: 5000 }; \
        const req = http.get(options, (res) => process.exit(res.statusCode === 200 ? 0 : 1)); \
        req.on('error', () => process.exit(1)); \
        req.on('timeout', () => { req.destroy(); process.exit(1); }); \
    "

# 启动命令（适配GitHub Actions的信号处理）
CMD ["node", "--trace-warnings", ".output/server/index.mjs"]