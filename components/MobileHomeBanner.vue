<script setup lang="ts">
import { Swiper, SwiperSlide } from 'swiper/vue';
import { Autoplay, Navigation, Pagination } from 'swiper/modules';
import 'swiper/swiper-bundle.css';

import Invitation from '@/assets/logo/swiper_1_h5.png';
import Share from '@/assets/logo/swiper_2_h5.png';
import Products from '@/assets/logo/swiper_3_h5.png';

const modules: any[] = [Autoplay, Navigation, Pagination];

interface BannerItem {
  key: string;
  img: string;
}
const bannerList = computed(() => {
  const list: BannerItem[] = [
    { key: 'Invitation', img: Invitation },
    { key: 'Share', img: Share },
    { key: 'Products', img: Products }
  ];
  return list;
});

const goVigorbuy = () => {
  openLink("https://vigorbuy.com/appreciation");
};

const goDiscord = () => {
  openLink("https://discord.com/invite/nmRxUPDK9m");
};

const openLink = (url: string, target = '_blank') => {
   const a = document.createElement('a');
    a.setAttribute('href', url);
    a.setAttribute('target', target);
    a.setAttribute('id', 'camnpr');
    document.body.appendChild(a);
    a.click();
};

const goJump = (bannerKey: string) => {
  switch (bannerKey) {
    case 'Invitation':
      goVigorbuy();
      break;
    case 'Share':
      goDiscord();
      break;
    case 'Products':
      openLink('https://t.me/VigorbuyFinds');
      break;
    default:
      break;
  }
};
</script>

<template>
  <swiper
    class="banner-carousel"
    :slides-per-view="1"
    :space-between="0"
    :autoplay="{
      delay: 3000,
      disableOnInteraction: false,
    }"
    :navigation="true"
    :loop="true"
    :modules="modules"
    :pagination="{ type: 'bullets', clickable: true }"
  >
    <swiper-slide v-for="item in bannerList" :key="item.key">
      <div class="activity-card" @click="goJump(item.key)" :style="{ backgroundImage: `url(${item.img})` }"></div>
    </swiper-slide>
  </swiper>
</template>

<style lang="scss" scoped>
:deep(.swiper-button-prev) {
  width: 34px;
  height: 34px;
  border-radius: 34px;
  background-color: rgba(0, 0, 0, 0.5);
  opacity: 0;

  &::after {
    font-size: 14px;
    color: #fff !important;
    margin-left: -2px;
  }
}

:deep(.swiper-button-next) {
  width: 34px;
  height: 34px;
  border-radius: 34px;
  background-color: rgba(0, 0, 0, 0.5);
  opacity: 0;

  &::after {
    font-size: 14px;
    color: #fff;
    margin-right: -2px;
  }
}

.banner-carousel {
  border-radius: 8px;
  &:hover {
    :deep(.swiper-button-next) {
      opacity: 1 !important;
      color: #fff;
      svg{
        width: auto;
        height: auto;
      }
    }

    :deep(.swiper-button-prev) {
      opacity: 1 !important;
      color: #fff;
      svg{
        width: auto;
        height: auto;
      }
    }
  }
}

:deep(.swiper-pagination-bullet-active) {
  background: #fff;
}

.activity-card {
  height: 88px;
  // padding-bottom: 48%;
  background: no-repeat center;
  // background-size: cover;
  // border-radius: 12px;
  position: relative;
  background-size: 100% 100%;
  cursor: pointer;
}

@media screen and (max-width: 768px) {
  .activity-card {
    border-radius: 8px;
  }

  :deep(.swiper-button-next) {
    display: none;
  }

  :deep(.swiper-button-prev) {
    display: none;
  }
}
</style>
