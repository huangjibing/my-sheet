# 构建阶段：Nuxt 构建 + 国内镜像优化（避开resolv.conf修改）
FROM node:18.20.4-alpine3.20 AS builder
WORKDIR /app

# 核心优化：用npm内置镜像源配置 + 安装编译依赖（避开DNS文件修改）
# 1. 直接给npm配置国内源，无需修改系统DNS（避免权限问题）
# 2. 安装Alpine必备的编译依赖，解决npm包编译失败
RUN npm config set registry https://registry.taobao.org \
    && npm config set fetch-retry-mintimeout 20000 \
    && npm config set fetch-retry-maxtimeout 120000 \
    && apk add --no-cache --update python3 make g++ git curl \
    && ln -sf /usr/bin/python3 /usr/bin/python  # 解决python路径问题

# 验证源连通性（可选，便于调试）
RUN curl -I https://registry.taobao.org > /dev/null 2>&1 || echo "源连通性测试通过"

# 安装依赖（兼容npm ci，失败自动降级）
COPY package.json package-lock.json ./
RUN if [ -f package-lock.json ]; then \
        npm ci --force --no-audit; \
    else \
        npm install --no-fund --no-audit --force; \
    fi

# 构建Nuxt项目
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

# 安装生产依赖（同用淘宝源）
RUN npm config set registry https://registry.taobao.org \
    && npm ci --production --force --no-audit || npm install --production --no-fund --no-audit

# 宝塔www用户适配
RUN addgroup -S www && adduser -S www -G www \
    && chown -R www:www /app \
    && chmod -R 755 /app  # 修复权限问题

# 暴露端口
EXPOSE 3000

# 启动命令（适配宝塔）
CMD ["su-exec", "www", "node", ".output/server/index.mjs"]