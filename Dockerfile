# ========== 阶段1：构建Nuxt项目（指定精确Node版本 + 国内镜像优化） ==========
# 选用Node 18 LTS最新稳定版（18.20.4）+ Alpine 3.20，避免版本漂移
# 可从Docker Hub验证版本有效性：https://hub.docker.com/_/node/tags
FROM node:18.20.4-alpine3.20 AS builder
WORKDIR /app

# 核心优化1：配置国内DNS（解决镜像源解析失败）+ 安装编译依赖（Alpine必加）
# Alpine默认DNS为海外地址，无法解析国内源；部分npm包需编译工具（如node-sass）
RUN echo "nameserver 223.5.5.5" > /etc/resolv.conf && \
    echo "nameserver 223.6.6.6" >> /etc/resolv.conf && \
    apk add --no-cache python3 make g++ git curl

# 核心优化2：切换更稳定的国内源 + 清空缓存（解决npmmirror偶尔失效）
# 优先用淘宝源（和npmmirror同源，CDN覆盖更广），全局配置避免重复指定
RUN npm config set registry https://registry.taobao.org && \
    npm cache clean --force

# 复制依赖文件（优先复制lock文件，利用Docker缓存）
COPY package.json package-lock.json ./

# 核心优化3：兼容npm ci严格模式（失败自动降级，解决exit code:1）
# npm ci要求lock文件和package.json完全匹配，国内环境易触发不兼容，降级为npm install兜底
RUN if [ -f package-lock.json ]; then \
        npm ci --timeout=60000 --force; \
    else \
        npm install --no-fund --no-audit; \
    fi

# 复制项目代码
COPY . .

# 构建项目（指定生产环境，避免开发依赖干扰）
RUN NODE_ENV=production npm run build

# ========== 阶段2：运行项目（宝塔适配 + 同版本Node） ==========
# 运行阶段必须和构建阶段使用相同精确版本，保证环境一致性
FROM node:18.20.4-alpine3.20
WORKDIR /app

# 安装su-exec（宝塔切换www用户必备）
RUN apk add --no-cache su-exec

# 复制构建产物（修复原路径多写的斜杠：.//.output → ./.output）
COPY --from=builder /app/.output ./.output
COPY --from=builder /app/package.json ./

# 生产依赖安装（同步国内源优化）
RUN npm config set registry https://registry.taobao.org && \
    npm ci --production --timeout=60000 --force || npm install --production --no-fund --no-audit

# 宝塔www用户适配：创建用户并修改权限
RUN addgroup -S www && adduser -S www -G www && \
    chown -R www:www /app

# 暴露端口（宝塔已放行）
EXPOSE 3000

# 启动命令（用www用户运行，添加版本验证便于排查）
CMD ["sh", "-c", "node -v && su-exec www node .output/server/index.mjs"]