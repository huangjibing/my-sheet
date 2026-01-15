# 构建阶段（GitHub Actions海外环境优化）
FROM node:18-alpine AS builder
WORKDIR /app
# 海外时区配置（推荐UTC，避免不同地区时区混乱）
ENV TZ=UTC

# 安装构建依赖（海外alpine源更稳定）
RUN apk add --no-cache python3 make g++ git && ln -sf python3 /usr/bin/python

# 🌟 海外专属npm源优化（核心调整）
RUN npm config set registry https://registry.npmjs.org \
    && npm config set unsafe-perm true \
    && npm config set fetch-retry-maxtimeout 60000 \
    && npm config set fetch-retry-mintimeout 10000 \
    && npm config set strict-ssl false  # 避免海外节点SSL校验偶发失败

# 缓存依赖（GitHub Actions缓存优化）
COPY package.json package-lock.json ./
RUN npm install --no-fund --no-audit --prefer-offline

# 构建项目（适配Nuxt3海外部署）
COPY . .
RUN npm run build && rm -rf node_modules

# 运行阶段（海外宝塔服务器适配）
FROM node:18-alpine AS runner
WORKDIR /app
ENV TZ=UTC
ENV NODE_ENV=production
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

# 创建非root用户（海外宝塔安全规范）
RUN addgroup -g 1001 -S nodejs && adduser -S nuxt -u 1001 -G nodejs
RUN chown -R nuxt:nodejs /app
USER nuxt

# 复制构建产物
COPY --from=builder /app/.output ./.output

# 暴露端口（海外宝塔反向代理适配）
EXPOSE 3000

# 健康检查（海外宝塔容器监控，用curl替代wget，alpine默认更轻量）
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -f http://localhost:3000/_health || exit 1

# 启动命令（适配海外宝塔的容器重启策略）
CMD ["node", ".output/server/index.mjs"]