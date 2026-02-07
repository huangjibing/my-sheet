<script setup lang="ts">
  import { useBaseStore } from "@/store/base";
  const version = ref('0.0.0.1');
  const baseStore = useBaseStore();
  const loading = ref(true);
  const page = ref(1);
  const maxPage = ref(21);
  const initData = async () => {
    let versionStor = localStorage.getItem('version');
    if ((versionStor && versionStor != version.value) || !versionStor) {
      await clearStoreData("productDB", "products")
    }
    const result = await queryDataFromDB("productDB", "products");
    if (result && result.length > 0) {
      baseStore.setProductAll(result);
      setTimeout(() => {
        loading.value = false;
      }, 500)
      localStorage.setItem('version', version.value);
      return;
    } else {
      console.info(new Date(), '开始加载')
      const res = await import(`@/assets/json/sliced-json/products_${page.value}.json`);
      const sliceData = res.default;
      console.info(new Date(), '加载完成', sliceData)
      baseStore.setProductAll(sliceData);
      loading.value = false;
      page.value += 1;
      if (page.value > maxPage.value) {
        console.info('所有json数据加载完成');
        const list = baseStore.getProductAll();
        initDBAndWriteData("productDB", "products", list)
        localStorage.setItem('version', version.value);
        return;
      }
      setTimeout(() => {
        initData();
      }, 1500) 
    }
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