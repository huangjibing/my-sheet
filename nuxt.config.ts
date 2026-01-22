// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  ssr: false,
  devServer: {
    port: 3004,
    host: "0.0.0.0",
  },
  // 静态资源优化：启用缓存哈希（避免浏览器缓存旧资源）
  nitro: {
    preset: 'node-server', // Node 部署模式必填
    output: {
      dir: '.output'
    },
    routeRules: {
      // 为所有路由设置 X-Frame-Options 和 CSP 头
      '/**': {
        headers: {
          'X-Frame-Options': 'DENY',
          'Content-Security-Policy': "frame-ancestors 'none';", // 限制 iframe 嵌入
        },
      },
    }
  },
  app: {
    baseURL: '/', // 必须部署在根目录，禁止子目录（否则 _nuxt 路径会多一层）
    buildAssetsDir: '_nuxt', // 固定值，禁止修改（Nuxt 打包后静态资源目录固定为 _nuxt）
    cdnURL: '', // 留空，避免强制拼接 CDN 路径导致 404
    head: {
      charset: "utf-8",
      viewport: "width=device-width, initial-scale=1",
      title: "Vigorbuysheet",
      link: [
        {
          rel: 'canonical',
          href: 'https://vigorbuysheet.com/'
        },
        {
          rel: 'icon',
          sizes: '32x32',
          type: 'ico',
          href: 'https://cdn.static.vigorbuy.com/assets/favicon/favicon_32.ico',
        },
        {
          rel: 'icon',
          sizes: '16x16',
          type: 'ico',
          href: 'https://cdn.static.vigorbuy.com/assets/favicon/favicon_16.ico',
        },
        {
          rel: 'icon',
          sizes: '48x48',
          type: 'ico',
          href: 'https://cdn.static.vigorbuy.com/assets/favicon/favicon_48.ico',
        },
        {
          rel: 'icon',
          sizes: '64x64',
          type: 'ico',
          href: 'https://cdn.static.vigorbuy.com/assets/favicon/favicon_64.ico',
        }
      ],
      meta: [
        {
          name: 'viewport',
          // 核心：添加 minimum-scale/maximum-scale 锁定缩放
          content: 'width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover'
        },
        {
          name: "description",
          content:
            "Discover the ultimate Vigorbuy spreadsheet at Vigorbuysheet! With over 2000 top Vigorbuy finds and detailed QC photos, it’s your essential resource for discovering the best products on Vigorbuy.",
        },
        {
          property: "og:description",
          content:
            "Discover the ultimate Vigorbuy spreadsheet at Vigorbuysheet! With over 2000 top Vigorbuy finds and detailed QC photos, it’s your essential resource for discovering the best products on Vigorbuy.",
        },
        {
          name: "twitter:description",
          content:
            "Discover the ultimate Vigorbuy spreadsheet at Vigorbuysheet! With over 2000 top Vigorbuy finds and detailed QC photos, it’s your essential resource for discovering the best products on Vigorbuy.",
        },
      ],
    },
  },
  compatibilityDate: "2024-11-01",
  devtools: { enabled: false },
  css: [
    "@/style/reset.scss",
    "@/style/common.scss",
    '@/style/iconfont/iconfont.css'
  ],
  modules: [
    "@pinia/nuxt",
    "@element-plus/nuxt",
    "@nuxtjs/tailwindcss",
  ],
  // tailwindcss: {
  //   exposeConfig: false, // 避免配置暴露导致的冲突
  //   viewer: true // 对应你能打开的 _tailwind/ 页面，保持开启即可
  // }
});
