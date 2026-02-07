<script setup lang="ts">
  import { useBaseStore } from "@/store/base";
  const baseStore = useBaseStore();
  const loading = ref(true);
  const initData = async () => {
    console.info(new Date(), '开始加载')
    const res = await import(`@/assets/json/products1.json`);
    const sliceData = res.default;
    baseStore.setProductAll(sliceData);
    loading.value = false;
    console.info(new Date(), '加载完成', sliceData)
  }
  // const mediaQueryList = ref<MediaQueryList>();
  // const userStore = useUserStore();
  // const listener = (mql: MediaQueryListEvent) => {
  //   userStore.setIsMobile(mql.matches);
  // };

  // const removeListenerOfResize = () => {
  //   mediaQueryList.value?.removeEventListener('change', listener);
  // };
  // const addListenerOfResize = () => {
  //   mediaQueryList.value = window.matchMedia('(max-width: 768px)');
  //   userStore.setIsMobile(mediaQueryList.value.matches);
  //   mediaQueryList.value?.addEventListener('change', listener);
  // }
  // const resizeListener = () => {
  //   const doc = document.documentElement;
  //   doc.style.setProperty('--browser-height', `${window.innerHeight}px`);
  // };

  onBeforeMount(() => {
    // addListenerOfResize();
    // resizeListener();
    // window.addEventListener('resize', resizeListenerlab()
  })
  onMounted(() => {
    initData()
  })
  onUnmounted(() => {
    // removeListenerOfResize();
    // window.removeEventListener('resize', resizeListener);
  })
</script>
<template>
  <div v-loading="loading"
    element-loading-text="Loading..."
    element-loading-svg-view-box="-10, -10, 50, 50"
    element-loading-background="rgba(122, 122, 122, 0.8)">
     <NuxtLayout name="desktop">
        <NuxtPage />
    </NuxtLayout>
  </div>
</template>
<style lang="scss" scoped>

</style>