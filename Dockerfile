# ========== 构建阶段（Builder）：命名阶段，优化依赖安装和构建 ==========
# 1. 改用ghcr.io的alpine镜像（GitHub拉取更快），并命名为builder
FROM ghcr.io/nodejs/node:18-alpine AS builder

# 2. 设置工作目录，赋予足够权限（适配GitHub CI的权限限制）
WORKDIR /app
RUN chmod 777 /app

# 3. 替换alpine的包管理器（alpine用apk而非apt-get，原命令会直接失败！）
# 安装构建依赖（python3/make/g++），并清理缓存减小镜像体积
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    && ln -sf python3 /usr/bin/python  # 统一python命令指向python3

# 4. 优化npm配置（适配GitHub网络/权限，提升安装稳定性）
RUN npm config set registry https://registry.npmjs.org \
    && npm config set cache /tmp/npm-cache \
    && npm config set strict-ssl false \
    && npm config set unsafe-perm true

# 5. 先复制依赖文件（利用Docker层缓存，避免代码变动重新install）
COPY package.json package-lock.json ./

# 6. 执行npm install，添加适配参数（GitHub环境更稳定）
RUN npm install \
    --no-fund \
    --no-audit \
    --ignore-optional \  # 忽略可选依赖，减少构建失败概率
    && rm -rf /tmp/npm-cache  # 清理缓存，减小构建层体积

# 7. 复制项目代码并构建（最后复制代码，最大化缓存利用率）
COPY . .
RUN npm run build \
    && rm -rf node_modules  # 清理构建阶段的依赖，仅保留构建产物

# ========== 运行阶段：精简镜像，仅保留运行所需文件 ==========
# 1. 改用ghcr.io的slim镜像（更安全，GitHub拉取更快）
FROM ghcr.io/nodejs/node:18-slim AS runner

# 2. 设置工作目录，创建非root用户（符合GitHub安全规范）
WORKDIR /app
RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 nodejs \
    && chown -R nodejs:nodejs /app

# 3. 设置生产环境变量，禁用npm更新提示
ENV NODE_ENV=production \
    NPM_CONFIG_UPDATE_NOTIFIER=false

# 4. 从构建阶段复制产物（仅复制必要文件，减小最终镜像体积）
COPY --from=builder --chown=nodejs:nodejs /app/.output ./.output

# 5. 切换到非root用户运行（降低安全风险，适配GitHub镜像扫描）
USER nodejs

# 6. 暴露端口（仅声明，实际端口由运行时映射）
EXPOSE 3000

# 7. 设置健康检查（增强容器可用性，符合生产标准）
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD node -e "try { require('http').get('http://localhost:3000/health', (res) => process.exit(res.statusCode === 200 ? 0 : 1)); } catch (e) { process.exit(1); }"

# 8. 启动命令（用exec形式，确保容器能正确接收信号）
CMD ["node", ".output/server/index.mjs"]