# 构建阶段：指定精确Node版本 + 国内镜像优化
FROM node:18.20.4-alpine3.20 AS builder
WORKDIR /app

# 国内网络优化：配置DNS+安装编译依赖
RUN echo "nameserver 223.5.5.5" > /etc/resolv.conf && \
    echo "nameserver 223.6.6.6" >> /etc/resolv.conf && \
    apk add --no-cache python3 make g++ git curl

# 切换淘宝源 + 清空缓存
RUN npm config set registry https://registry.taobao.org && \
    npm cache clean --force

# 安装依赖（兼容npm ci严格模式）
COPY package.json package-lock.json ./
RUN if [ -f package-lock.json ]; then \
        npm ci --timeout=60000 --force; \
    else \
        npm install --no-fund --no-audit; \
    fi

# 构建项目
COPY . .
RUN NODE_ENV=production npm run build

# 运行阶段：宝塔适配
FROM node:18.20.4-alpine3.20
WORKDIR /app

# 安装su-exec（切换www用户）
RUN apk add --no-cache su-exec

# 复制构建产物
COPY --from=builder /app/.output ./.output
COPY --from=builder /app/package.json ./

# 安装生产依赖
RUN npm config set registry https://registry.taobao.org && \
    npm ci --production --timeout=60000 --force || npm install --production --no-fund --no-audit

# 宝塔www用户适配
RUN addgroup -S www && adduser -S www -G www && \
    chown -R www:www /app

EXPOSE 3000
CMD ["su-exec", "www", "node", ".output/server/index.mjs"]