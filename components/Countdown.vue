<script setup lang="ts">
const isMobile = ref(false);
let userAgent = '';
if (import.meta.server) {
  const headers = useRequestHeaders();
  userAgent = headers['user-agent']?.toLowerCase() || '';
} else {
  userAgent = navigator.userAgent.toLowerCase();
}
const isMobiles = /iphone|ipad|ipod|android|windows phone|mobile/i.test(userAgent);
isMobile.value = isMobiles;

const hour = ref('00')
const minute = ref('00')
const second = ref('00')

const show = ref(false)

// 计算目标时间（当前时间 + 48小时）
const targetTime = new Date('2025-11-01T00:00:00').getTime();
// 格式化倒计时（只返回 时:分:秒，小时可累计超过24）
const formatCountdown = (diffMs: number): { hours: number; minutes: number; seconds: number; isEnd: boolean } => {
  if (diffMs <= 0) {
    return { hours: 0, minutes: 0, seconds: 0, isEnd: true };
  }

  // 总秒数 = 毫秒差 / 1000（向下取整）
  const totalSeconds = Math.floor(diffMs / 1000);
  // 小时 = 总秒数 / 3600（向下取整）
  const hours = Math.floor(totalSeconds / 3600);
  // 剩余秒数 = 总秒数 % 3600
  const remainingSeconds = totalSeconds % 3600;
  // 分钟 = 剩余秒数 / 60
  const minutes = Math.floor(remainingSeconds / 60);
  // 秒 = 剩余秒数 % 60
  const seconds = remainingSeconds % 60;

  return { hours, minutes, seconds, isEnd: false };
};

// 启动倒计时
const startCountdown = () => {
  // 定时器ID，用于清除倒计时
  let timer: NodeJS.Timeout;

  const updateCountdown = () => {
    const now = Date.now();
    const diffMs = targetTime - now; // 时间差（毫秒）
    const countdown = formatCountdown(diffMs);
    hour.value = (countdown.hours + '').padStart(2, '0');
    minute.value = (countdown.minutes + '').padStart(2, '0');
    second.value = (countdown.seconds + '').padStart(2, '0');

    // 倒计时结束，清除定时器
    if (countdown.isEnd) {
      clearInterval(timer);
      show.value = false;
    } else {
      show.value = true;
    }
  };

  // 立即执行一次（避免等待1秒才显示）
  updateCountdown();
  // 每1秒更新一次
  timer = setInterval(updateCountdown, 1000);

  // 返回清除定时器的方法（方便外部控制）
  return () => clearInterval(timer);
};
onMounted(() => {
    startCountdown();
})
</script>
<template>
    <div class="countdown" v-show="show">
        <span class="text">
        Discount ends
        </span>
        <span class="time ml-5">{{ hour }}</span>
        <span>:</span>
        <span class="time">{{ minute }}</span>
        <span>:</span>
        <span class="time">{{ second }}</span>
    </div>
</template>
<style lang="scss" scoped>
.countdown{
    height: 40px;
    display: flex;
    align-items: center;
    color: #FF4338;
    border-radius: 48px;
    background: #FFF;
    padding: 0px 10px;
    .text{
        font-size: 16px;
        font-style: normal;
        font-weight: 600;
    }
    .time{
        width: 28px;
        height: 23px;
        line-height: 23px;
        border-radius: 6.6px;
        background: #FF4338;
        text-align: center;
        color: #FFF;
        font-family: "PingFang SC";
        font-style: normal;
        font-weight: 400;
    }
}
@media screen and (max-width: 768px) {
    .countdown{
        background: none;
        .text{
            background-color: #FF4338;
            color: #fff;
            font-size: 12px;
            height: 20px;
            line-height: 20px;
            border-radius: 6.6px;
            padding: 0px 5px;
        }
        .time{
            font-size: 12px;
            height: 20px;
            line-height: 20px;
        }
    }
}
</style>