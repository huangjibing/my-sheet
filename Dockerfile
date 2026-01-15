# 构建阶段（GitHub Actions海外环境）
FROM node:18-alpine AS builder
WORKDIR /app
# 海外时区配置（UTC适配海外服务器）
ENV TZ=UTC

# 安装构建依赖（精简且兼容alpine）
RUN apk add --no-cache python3 make g++ git && ln -sf python3 /usr/bin/python

# 🌟 海外专属npm源优化（彻底修复语法+兼容性问题）
# 注释单独行，行续符后无空格，仅保留兼容的npm参数
RUN npm config set registry https://registry.npmjs.org \
    && npm config set unsafe-perm true \
    && npm config set strict-ssl false \
    && npm config set cache /tmp/npm-cache

# 缓存依赖（仅保留兼容参数，避免构建失败）
COPY package.json package-lock.json ./
RUN npm install --no-fund --no-audit --prefer-offline \
    && rm -rf /tmp/npm-cache

# 构建项目
COPY . .
RUN npm run build && rm -rf node_modules

# 运行阶段（海外宝塔服务器）
FROM node:18-alpine AS runner
WORKDIR /app
ENV TZ=UTC
ENV NODE_ENV=production
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

# 创建非root用户（符合海外宝塔安全规范）
RUN addgroup -g 1001 -S nodejs && adduser -S nuxt -u 1001 -G nodejs
RUN chown -R nuxt:nodejs /app
USER nuxt

# 复制构建产物
COPY --from=builder /app/.output ./.output

# 暴露端口
EXPOSE 3000

# 健康检查（用curl替代wget，alpine默认安装）
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -f http://localhost:3000/_health || exit 1

# 启动命令
CMD ["node", ".output/server/index.mjs"]