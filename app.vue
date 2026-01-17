<script setup lang="ts">
  import { useUserStore } from "@/store/user";
  const mediaQueryList = ref<MediaQueryList>();
  const userStore = useUserStore();
  const listener = (mql: MediaQueryListEvent) => {
    userStore.setIsMobile(mql.matches);
  };

  const removeListenerOfResize = () => {
    mediaQueryList.value?.removeEventListener('change', listener);
  };
  const addListenerOfResize = () => {
    mediaQueryList.value = window.matchMedia('(max-width: 768px)');
    userStore.setIsMobile(mediaQueryList.value.matches);
    mediaQueryList.value?.addEventListener('change', listener);
  }
  const resizeListener = () => {
    const doc = document.documentElement;
    doc.style.setProperty('--browser-height', `${window.innerHeight}px`);
  };

  onBeforeMount(() => {
    // addListenerOfResize();
    // resizeListener();
    // window.addEventListener('resize', resizeListener);
  })
  onMounted(() => {
  })
  onUnmounted(() => {
    // removeListenerOfResize();
    // window.removeEventListener('resize', resizeListener);
  })
</script>
<template>
  <NuxtLayout name="desktop">
    <NuxtPage />
  </NuxtLayout>
</template>
<style lang="scss" scoped>

</style>