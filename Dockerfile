# 构建阶段
FROM node:18-alpine AS builder
WORKDIR /app
ENV TZ=Asia/Shanghai  # 适配国内时区，宝塔日志更友好

# 安装构建依赖
RUN apk add --no-cache python3 make g++ git && ln -sf python3 /usr/bin/python

# 优化npm源（国内服务器拉取更快）
RUN npm config set registry https://registry.npmmirror.com \
    && npm config set unsafe-perm true

# 缓存依赖
COPY package.json package-lock.json ./
RUN npm install --no-fund --no-audit

# 构建项目
COPY . .
RUN npm run build && rm -rf node_modules

# 运行阶段（精简镜像，适配宝塔Docker管理器）
FROM node:18-alpine AS runner
WORKDIR /app
ENV TZ=Asia/Shanghai
ENV NODE_ENV=production
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

# 创建非root用户（宝塔运行更安全）
RUN addgroup -g 1001 -S nodejs && adduser -S nuxt -u 1001 -G nodejs
RUN chown -R nuxt:nodejs /app
USER nuxt

# 复制构建产物
COPY --from=builder /app/.output ./.output

# 暴露端口（宝塔反向代理需映射）
EXPOSE 3000

# 健康检查（宝塔可监控容器状态）
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget -qO- http://localhost:3000/_health || exit 1

# 启动命令（适配宝塔容器重启策略）
CMD ["node", ".output/server/index.mjs"]