/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./components/**/*.{js,vue,ts}",
    "./layouts/**/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./app.vue",
    "./nuxt.config.{js,ts}",
  ],
  // 关键：兜底保留所有渐变相关类（包括自定义色值）
  safelist: [
    // 匹配所有渐变方向类
    /^bg-gradient-to-.*/,
    // 匹配所有 from-[xxx]/xx 格式的类
    /^from-\[.*/,
    // 匹配所有 to-[xxx]/xx 格式的类
    /^to-\[.*/,
    // 显式声明你用到的具体类（双重保险）
    'bg-gradient-to-r',
    'from-[#ff3eaa]/20',
    'to-[#008cff]/20'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}