# 阶段1：构建Nuxt项目（通用）
FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --registry=https://registry.npmmirror.com  # 国内镜像加速
COPY . .
RUN npm run build

# 阶段2：运行项目（宝塔适配）
FROM node:18-alpine
WORKDIR /app
# 安装必要依赖（宝塔环境可能需要）
RUN apk add --no-cache su-exec
# 复制构建产物
COPY --from=builder /app/.output .//.output
COPY --from=builder /app/package.json ./
RUN npm ci --production --registry=https://registry.npmmirror.com

# 宝塔www用户适配：创建www用户（容器内）
RUN addgroup -S www && adduser -S www -G www
# 更改工作目录权限
RUN chown -R www:www /app

# 暴露端口（宝塔已放行）
EXPOSE 3000

# 启动命令：用www用户运行（适配宝塔权限）
CMD ["su-exec", "www", "node", ".output/server/index.mjs"]