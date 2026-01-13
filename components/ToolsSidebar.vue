<script setup lang="ts">
import type { FloatingPosition } from '~/types/base';
import { Close, ArrowLeft } from '@element-plus/icons-vue';
// const route = useRoute();
// const isHomePage = computed(() => {
//   return route.path === '/' || route.path === '/m/';
// });

const isShowBeginnerGuide = ref(false);
const isShowBeginnerGuideH5 = ref(false);

const openLink = (url: string, target = '_blank') => {
   const a = document.createElement('a');
    a.setAttribute('href', url);
    a.setAttribute('target', target);
    a.setAttribute('id', 'camnpr');
    document.body.appendChild(a);
    a.click();
};

const position = ref<FloatingPosition>({
  top: 0,
  right: 0,
  isRight: true,
});

const timer = ref();
const isPackUp = ref(true);
const handleUpdatePosition = (newPosition: FloatingPosition) => {
  position.value = newPosition;
  position.value = newPosition;
  if (newPosition.isRight === true) {
    position.value.right = 12;
  } else if (newPosition.isRight === false) {
    position.value.left = 12;
  }
  handlePickUp();
};
const handlePickUp = () => {
  if (timer.value) {
    clearTimeout(timer.value);
  }
  timer.value = setTimeout(() => {
    isPackUp.value = true;
  }, 3000);
};

const position1 = ref<FloatingPosition>({
  top: 0,
  right: 0,
  isRight: true,
});

const timer1 = ref();
const isPackUp1 = ref(true);
const handleUpdatePosition1 = (newPosition: FloatingPosition) => {
  position1.value = newPosition;
  if (newPosition.isRight === true) {
    position1.value.right = 12;
  } else if (newPosition.isRight === false) {
    position1.value.left = 12;
  }
  handlePickUp1();
};
const handlePickUp1 = () => {
  if (timer1.value) {
    clearTimeout(timer.value);
  }
  timer1.value = setTimeout(() => {
    isPackUp1.value = true;
  }, 3000);
};

const position2 = ref<FloatingPosition>({
  top: 0,
  right: 0,
  isRight: true,
});

const timer2 = ref();
const isPackUp2 = ref(true);
const handleUpdatePosition2 = (newPosition: FloatingPosition) => {
  position2.value = newPosition;
  if (newPosition.isRight === true) {
    position2.value.right = 12;
  } else if (newPosition.isRight === false) {
    position2.value.left = 12;
  }
  handlePickUp2();
};
const handlePickUp2 = () => {
  if (timer2.value) {
    clearTimeout(timer.value);
  }
  timer2.value = setTimeout(() => {
    isPackUp2.value = true;
  }, 3000);
};

const loding = ref(false);

const position4 = ref<FloatingPosition>({
  top: 0,
  right: 0,
  isRight: true,
});

onMounted(() => {
    position.value = {
        top: window.innerHeight - 300,
        right: 12,
        isRight: true,
    }
    position1.value = {
        top: window.innerHeight - 360,
        right: 12,
        isRight: true,
    }
    position2.value = {
        top: window.innerHeight - 420,
        right: 12,
        isRight: true,
    }
    position4.value = {
        top: window.innerHeight - 240,
        right: 12,
        isRight: true,
    }
    nextTick(() => {
      loding.value = true;
    })
})

const toTop = () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth' // 平滑滚动动画
  });
}

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

const openVideo = () => {
  if (isMobile.value) {
    isShowBeginnerGuideH5.value = true;
  } else {
    isShowBeginnerGuide.value = true;
  }
}

const router = useRouter();
const toPage = (path:string) => {
  router.push({
    path: path
  })
}

const showTools = ref(true);
</script>

<template>
  <div class="tools-sidebar-wrapper">
    <div v-show="showTools">
      <div class="beginner-guide-wrapper" @click="openVideo()">
        <img class="beginner-guide-img" src="@/assets/home/beginnerGuide.png" alt="" />
      </div>
      <div class="tools-content">
      <el-popover
        :width="458"
        placement="left"
        trigger="click"
        v-if="!isMobile">
          <template #reference>
            <div class="tool-item">
              <img width="32" height="32" src="@/assets/home/app_er.png" alt="">
            </div>
          </template>

          <template #default>
            <div style="display: flex;justify-content: center;">
              <div>
                <img width="199" height="199" src="@/assets/home/app_store.png" alt="">

                <div style="height: 24px;display: flex;justify-content: center;align-items: center;">
                  <img width="24" height="24" src="@/assets/home/iphone.png" alt="">
                  <div style="line-height: 24px;margin-left: 7px;font-size: 14px;font-weight: 700;color: #000000;">
                    App Store
                  </div>
                </div>
              </div>

              <div>
                <img width="199" height="199" src="@/assets/home/google_app.png" alt="">

                <div style="height: 24px;display: flex;justify-content: center;align-items: center;">
                  <img width="24" height="24" src="@/assets/home/google_play.png" alt="">
                  <div style="line-height: 24px;margin-left: 7px;font-size: 14px;font-weight: 700;color: #000000;">
                    Google Play
                  </div>
                </div>
              </div>
            </div>
          </template>
        </el-popover>

        <div class="tool-item" @click="openLink('https://t.me/VigorbuyFinds')">
          <img width="32" height="32" src="@/assets/logo/telegram.png" alt="">
        </div>
        <div class="tool-item" @click="openLink('https://discord.com/invite/nmRxUPDK9m')">
          <img width="32" height="32" src="@/assets/logo/discord.png" alt="">
        </div>

        <div class="tool-item" @click="toPage('/rule')">
          <img width="32" height="32" src="@/assets/logo/rule.png" alt="">
        </div>

        <div class="tool-item" @click="toTop()">
          <img width="32" height="32" src="@/assets/logo/top.png" alt="">
        </div>
      </div>
      <div class="close-btn" @click="showTools = false">
        <el-icon><Close /></el-icon>
      </div>
    </div>

    <div class="left-btn" v-show="!showTools" @click="showTools = true">
      <el-icon><ArrowLeft /></el-icon>
    </div>

    <div class="beginner-guide-dialog" v-if="isShowBeginnerGuide">
      <BeginnerVideo />
      <img class="close-img" src="@/assets/home/close_2.png" alt="" @click="isShowBeginnerGuide = false" />
    </div>
  </div>

  <div class="model" v-if="isShowBeginnerGuideH5 && isMobile">
        <div>
            <BeginnerVideo class="video" />
            <div style="margin-top: 10px;display: flex;justify-content: center;">
                <img class="close-img" src="@/assets/home/close_2.png" alt="" @click="isShowBeginnerGuideH5 = false" />
            </div>
        </div>
    </div>

  <!-- <div class="tools-sidebar-wrapper-h5" v-show="loding">
    <div
      style="position: fixed;z-index: 10;"
      :style="{
        top: position2.top + 'px',
        left: position2.left !== undefined ? position2.left + 'px' : undefined,
        right: position2.right !== undefined ? position2.right + 'px' : undefined,
      }"
      @click="isShowBeginnerGuideH5 = true"
    >
      <FloatingDrag :position="position2" @onUpdatePosition="handleUpdatePosition2">
        <img style="width: 42px; height: 42px" src="@/assets/home/beginnerGuide.png" alt="" />
      </FloatingDrag>
    </div>

    <div
      style="position: fixed;z-index: 10;"
      :style="{
        top: position1.top + 'px',
        left: position1.left !== undefined ? position1.left + 'px' : undefined,
        right: position1.right !== undefined ? position1.right + 'px' : undefined,
      }"
      @click="openLink('https://t.me/VigorbuyFinds')"
    >
      <FloatingDrag :position="position1" @onUpdatePosition="handleUpdatePosition1">
        <img style="width: 42px; height: 42px" src="@/assets/logo/telegram.png" alt="" />
      </FloatingDrag>
    </div>

    <div
      style="position: fixed;z-index: 10;"
      :style="{
        top: position.top + 'px',
        left: position.left !== undefined ? position.left + 'px' : undefined,
        right: position.right !== undefined ? position.right + 'px' : undefined,
      }"
      @click="openLink('https://discord.com/invite/nmRxUPDK9m')"
    >
      <FloatingDrag :position="position" @onUpdatePosition="handleUpdatePosition">
        <img style="width: 42px; height: 42px" src="@/assets/logo/discord.png" alt="" />
      </FloatingDrag>
    </div>

    <div
    style="position: fixed;z-index: 10;width: 40px;height: 40px;
    display: flex;align-items: center;justify-content: center;
    background-color: #fff;
    border-radius: 5px;"
    :style="{
      top: position4.top + 'px',
      right: position4.right + 'px'
    }"
    @click="toTop()">
      <img width="30" height="30" src="@/assets/logo/top.png" alt="">
    </div>

    <div class="model" v-if="isShowBeginnerGuideH5">
        <div>
            <BeginnerVideo class="video" />
            <div style="margin-top: 10px;display: flex;justify-content: center;">
                <img class="close-img" src="@/assets/home/close_2.png" alt="" @click="isShowBeginnerGuideH5 = false" />
            </div>
        </div>
    </div>
  </div> -->
</template>

<style lang="scss" scoped>
.close-btn{
  display: flex;
  justify-content: center;
  margin-top: 5px;
  color: rgb(153, 153, 153);
  font-size: 20px;
  font-weight: 900;
  cursor: pointer;
  width: 30px;
  height: 30px;
  align-items: center;
  background-color: rgba($color: #000000, $alpha: 0.3);
  margin-left: auto;
  margin-right: auto;
  color: #fff;
  border-radius: 50%;
}
.left-btn{
  background-color: #000000bf;
  font-size: 16px;
  padding: 30px 3px;
  transform: translate(8px);
  border-radius: 5px 0 0 5px;
  color: #fff;
  cursor: pointer;
  &:hover{
    color: #ff4800 !important;
  }
}
.tools-sidebar-wrapper {
  position: fixed;
  top: 0;
  bottom: 0;
  right: 16px;
  margin: auto;
  height: max-content;
  z-index: 10;
}
.beginner-guide-wrapper {
  margin-bottom: 12px;
  .beginner-guide-img {
    width: 60px;
    vertical-align: top;
    cursor: pointer;
  }
}

.beginner-guide-dialog {
  position: fixed;
  right: 100px;
  bottom: max(100px, calc(100vh - 329px) / 2);
  width: min(576px, 329px);
  z-index: 100;
  .close-img {
    position: absolute;
    width: 30px;
    height: 30px;
    top: 8px;
    right: 8px;
    cursor: pointer;
  }
}

.tools-content {
  padding: 12px 8px;
  display: flex;
  flex-direction: column;
  row-gap: 12px;
  border-radius: 8px;
  border: 1px solid #f5f6f7;
  background: #F5F6FA;
  .tool-item {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 42px;
    height: 42px;
    color: #c3cad9;
    border-radius: 4px;
    cursor: pointer;
    &:hover {
      background-color: var(--bg);
      color: var(--text-01);
    }
    &.discord,
    &.discord:hover {
      background-color: #425bf8;
      color: #fff;
    }
    .icon-font {
      font-size: 42px;
    }
  }
}

.telegram-img {
  margin-top: 20px;
  width: 60px;
  vertical-align: top;
  cursor: pointer;
}

.tools-sidebar-wrapper-h5{
    display: none;
}
@media screen and (max-width: 768px) {
    .tools-sidebar-wrapper{
        // display: none;
    }
    .close-btn{
      width: 27px;
      height: 27px;
      font-size: 16px;
    }
    .left-btn{
      padding: 20px 2px;
    }
    .beginner-guide-wrapper{
      .beginner-guide-img{
        width: 48px;
      }
    }
    .tools-content{
      background-color: #fff;
      gap: 5px;
      padding: 8px 0px;
      .tool-item{
        width: 48px;
      }
    }
    .model{
        position: fixed;
        top: 0px;
        width: 100vw;
        height: 100vh;
        background-color: rgba($color: #000000, $alpha: 0.5);
        display: flex;
        align-items: center;
        z-index: 100;
        justify-content: center;
        .video{
            width: 95vw;
        }
        .close-img {
            width: 30px;
            height: 30px;
            cursor: pointer;
        }
    }
    .tools-sidebar-wrapper-h5{
        // display: block;
    }
}
</style>
