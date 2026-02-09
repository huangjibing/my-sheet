<script setup lang="ts">
  import { useBaseStore } from "@/store/base";
  const version = ref('0.0.0.4');
  const baseStore = useBaseStore();
  const loading = ref(true);
  const page = ref(1);
  const maxPage = ref(21);
  const initData = async () => {
    let versionStor = localStorage.getItem('version');
    /**
     * 判断版本号 版本号不同 清除缓存重新拉取数据
     * 记录同步页码
     */
    if ((versionStor && versionStor != version.value) || !versionStor) {
      localStorage.removeItem('initDataPage');
      await clearStoreData("productDB", "products")

      localStorage.setItem('version', version.value);
    }

    const initDataPage = localStorage.getItem('initDataPage');
    if (initDataPage) {
      page.value = parseInt(initDataPage);
    }

    if (page.value > maxPage.value) {
      const result = await queryDataFromDB("productDB", "products");
      baseStore.setProductAll(result);
    } else {
      // console.info(new Date(), '开始加载', page.value)
      const res = await import(`@/assets/json/sliced-json/products_${page.value}.json`);
      const sliceData = res.default;
      // console.info(new Date(), '加载完成', sliceData)
      baseStore.setProductAll(sliceData);
      initDBAndWriteData("productDB", "products", sliceData)
      loading.value = false;
      page.value += 1;
      localStorage.setItem('initDataPage', page.value + '')
      if (page.value > maxPage.value) {
        // console.info('所有json数据加载完成');
        return;
      }
      setTimeout(() => {
        initData();
      }, 1500) 
    }


    // const result = await queryDataFromDB("productDB", "products");
    // if (result && result.length > 0) {
    //   baseStore.setProductAll(result);
    //   setTimeout(() => {
    //     loading.value = false;
    //   }, 500)
    //   localStorage.setItem('version', version.value);
    //   return;
    // } else {

    // }
  }

  onMounted(async () => {
    await initData();
  })
  onUnmounted(() => {
  })
</script>
<template>
  <NuxtLayout name="desktop">
    <NuxtPage />
  </NuxtLayout>
</template>
<style lang="scss" scoped>

</style>