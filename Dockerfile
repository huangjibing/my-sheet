# 构建阶段：对齐 Cloud Build 的 node:18-slim (Debian) 环境
FROM node:18-slim AS builder
WORKDIR /app

# 1. 先安装 git（解决 git config 命令未找到问题）
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. 复用 Cloud Build 的 Git 协议替换（现在 git 已安装，可正常执行）
RUN git config --global url."https://github.com/".insteadOf git@github.com: \
    && git config --global url."https://".insteadOf git://

# 3. 配置 npm 超时/源（兼容国内网络，同时保留国际源能力）
RUN npm config set fetch-retry-mintimeout 30000 \
    && npm config set fetch-retry-maxtimeout 180000 \
    && npm config set registry https://registry.npmjs.org/  # 优先用官方源（Cloud Build 同款）
    # 如需国内网络适配，可注释上面一行，启用下面的 npmmirror 源
    # && npm config set registry https://registry.npmmirror.com/

# 4. 安装 Debian 系统的编译依赖（解决 npm 包编译问题）
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    make \
    g++ \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 6. 安装依赖（对齐 Cloud Build 的 root 权限，无需 unsafe-perm）
COPY package.json package-lock.json* ./
RUN npm cache clean --force \
    && if [ -f package-lock.json ]; then \
        npm ci --no-audit --no-fund; \
    else \
        npm install --no-audit --no-fund; \
    fi

# 7. 构建 Nuxt 项目（延长超时，增加内存限制）
COPY . .
RUN NODE_ENV=production \
    NODE_OPTIONS="--max-old-space-size=4096" \
    && npm run build

# 运行阶段：宝塔适配 + node:18-slim 基础
FROM node:18-slim
WORKDIR /app

# 1. 运行阶段如需 git（可选，若运行时无需克隆依赖可删除）
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    gosu \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. 复用 Git 协议配置（仅当运行时需要 git 才保留）
RUN git config --global url."https://github.com/".insteadOf git@github.com: \
    && git config --global url."https://".insteadOf git://

# 3. 安装生产依赖
COPY --from=builder /app/.output ./.output
COPY --from=builder /app/package.json ./
RUN npm config set registry https://registry.npmjs.org/ \
    && npm ci --production --no-audit --no-fund

# 4. 宝塔 www 用户适配（Debian 系统用户创建方式）
RUN groupadd -r www && useradd -r -g www www \
    && chown -R www:www /app \
    && chmod -R 755 /app

# 暴露端口
EXPOSE 3000

# 启动命令（用 gosu 替代 su-exec，适配 Debian 系统）
CMD ["gosu", "www", "node", ".output/server/index.mjs"]