# 阶段1: 构建阶段 - 使用官方Node镜像作为构建环境
FROM node:20-alpine AS builder

# 设置工作目录
WORKDIR /app

# 复制package.json和package-lock.json（或yarn.lock/pnpm-lock.yaml）
# 先复制依赖文件可以利用Docker缓存，避免每次代码变动都重新安装依赖
COPY package*.json ./

# 安装pnpm（Nuxt3官方推荐的包管理器，也可替换为npm/yarn）
RUN npm install -g pnpm

# 安装项目依赖（包括开发依赖，因为构建Nuxt3需要）
RUN pnpm install

# 复制项目所有源代码
COPY . .

# 构建Nuxt3项目（生成.output目录）
RUN pnpm run build

# 阶段2: 运行阶段 - 精简镜像，只保留运行所需文件
FROM node:20-alpine AS runner

# 设置工作目录
WORKDIR /app

# 设置环境变量：生产环境、指定Nuxt运行端口
ENV NODE_ENV=production
ENV PORT=3000

# 从构建阶段复制构建产物和依赖文件
COPY --from=builder /app/.output ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# 暴露端口（与环境变量PORT一致）
EXPOSE 3000

# 启动Nuxt3服务（Nuxt3的生产启动命令）
CMD ["node", "dist/server/index.mjs"]