# ========== 构建阶段（Builder）：命名阶段，优化依赖安装和构建 ==========
FROM ghcr.io/nodejs/node:18-alpine AS builder

# 设置工作目录，赋予足够权限（适配GitHub CI的权限限制）
WORKDIR /app
RUN chmod 777 /app

# 替换alpine的包管理器（alpine用apk而非apt-get）
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    && ln -sf python3 /usr/bin/python  # 统一python命令指向python3

# 优化npm配置（适配GitHub网络/权限，提升安装稳定性）
RUN npm config set registry https://registry.npmjs.org \
    && npm config set cache /tmp/npm-cache \
    && npm config set strict-ssl false \
    && npm config set unsafe-perm true

# 先复制依赖文件（利用Docker层缓存）
COPY package.json package-lock.json ./

# 执行npm install（修复行续符+注释冲突问题）
# 注释放在行首/独立行，避免干扰行续符
RUN npm install \
    --no-fund \
    --no-audit \
    --ignore-optional \
    && rm -rf /tmp/npm-cache  # 清理缓存，减小构建层体积

# 复制项目代码并构建
COPY . .
RUN npm run build \
    && rm -rf node_modules  # 清理构建阶段的依赖，仅保留构建产物

# ========== 运行阶段：精简镜像 ==========
FROM ghcr.io/nodejs/node:18-slim AS runner

# 设置工作目录，创建非root用户
WORKDIR /app
RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 nodejs \
    && chown -R nodejs:nodejs /app

# 设置生产环境变量
ENV NODE_ENV=production \
    NPM_CONFIG_UPDATE_NOTIFIER=false

# 从构建阶段复制产物
COPY --from=builder --chown=nodejs:nodejs /app/.output ./.output

# 切换到非root用户
USER nodejs

# 暴露端口
EXPOSE 3000

# 健康检查
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD node -e "try { require('http').get('http://localhost:3000/health', (res) => process.exit(res.statusCode === 200 ? 0 : 1)); } catch (e) { process.exit(1); }"

# 启动命令
CMD ["node", ".output/server/index.mjs"]