<script setup lang="ts">
import { useBaseStore } from "@/store/base";

const route = useRoute();
const classify = route.params.classify.toString();
type StringDictionary = {
  [key: string]: string;
};
const typeList:StringDictionary = {
  '1': 'Popular: 30% Off',
  '2': 'Surprise: From 50% Off',
  '3': 'Insane Deals: 80% Off',
  '4': 'Premium Products: 5% Off'
}

const baseStore = useBaseStore();
const productList = computed(() => {
  return baseStore.getProductTypeSortList(typeList[classify], lastCategory.value != 'All' ? lastCategory.value : firstCategory.value);
});

const pageSize = ref(1);
const productCurList = computed(() => {
  let list = productList.value.sort((a,b) => {
    return sort.value == false ? a.discountedPrice - b.discountedPrice : b.discountedPrice -a.discountedPrice
  }).slice(0, pageSize.value * 40);
  return list;
});

const handleScroll = (e: any) => {
  if (!e.target) return;
  const { scrollTop, clientHeight, scrollHeight } = e.target.documentElement;
  if (
    scrollTop + clientHeight + 600 >= scrollHeight &&
    productList.value.length > productCurList.value.length
  ) {
    pageSize.value += 1;
  }
};
onMounted(() => {
  window.addEventListener("scroll", handleScroll);
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});
const sort = ref(false);
const sortClick = () => {
  pageSize.value = 1;
  sort.value = !sort.value;
}
const firstCategory = ref('');
const lastCategory = ref('');
const onSelect = (first:string, last:string) => {
  pageSize.value = 1;
  firstCategory.value = first;
  lastCategory.value = last;
}
</script>

<template>
  <div class="home-ategory">
      <CategorySelection :isBrand="true" @onSelect="onSelect" />
    </div>
  <div class="filter">
    <div class="fillter-box" @click="sortClick()">
      <span class="text">Price</span>
       <span class="jt">{{ sort == false ? '▼' : '▲' }}</span>
    </div>
  </div>
  <div class="classify-wrapper">
    <div class="products-list" v-if="productCurList.length">
      <ProductItem
        v-for="item in productCurList"
        :productInfo="item"
        :key="item.id"
      />
    </div>

     <div class="empty-wrapper" v-else>
      <img class="empty-img" src="@/assets/imgs/products_empty.png" alt="" />
      <div>No products found</div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.home-ategory{
  width: 1440px;
  margin-left: auto;
  margin-right: auto;
  position: sticky;
  top: 72px;
  height: 60px;
  display: flex;
  align-items: center;
  z-index: 999;
  background-color: #fff;
}
.filter{
  width: 1400px;
  margin-left: auto;
  margin-right: auto;
  .fillter-box{
    display: inline-block;
    cursor: pointer;
    padding: 5px 10px;
    // background-color: #ffffff;
    background: #F5F6FA;
    border-radius: 20px;
    .text{
    // color: #ffffff;
    }
    .jt{
      font-size: 10px;
      // color: #ffffff;
      margin-left: 5px;
    }
  }
}
.classify-title {
  font-size: 48px;
  text-align: center;
}
.classify-wrapper{
  // background-color: #ffffff;
  background: #F5F6FA;
  border-radius: 20px;
  margin-top: 30px;
  width: 1400px;
  padding: 20px;
  margin-left: auto;
  margin-right: auto;
  position: relative;
  .products-list {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 20px;
    // padding: 24px 48px 64px;
  }
  .empty-wrapper {
    margin: auto;
    text-align: center;
    font-size: 16px;
    color: #999;
  }
  .empty-img {
    vertical-align: top;
    max-width: min(25%, 150px);
  }
}

@media screen and (max-width: 1024px) {
  .products-list {
    gap: 32px;
    grid-template-columns: repeat(3, 1fr);
  }
}
@media screen and (max-width: 768px) {
  .home-ategory{
    width: 100vw;
    overflow-y: hidden;
    overflow-x: auto;
    height: 50px;
    background-color: #F5F8FD;
    position: sticky;
    top: 45px;
    margin-bottom: 10px;
  }
  .home-ategory::-webkit-scrollbar {
    height: 0;
  }
  .filter{
    width: 95vw;
    .fillter-box{
      background-color: transparent;
      padding: 0px;
    }
  }
  .classify-wrapper{
    margin-top: 10px;
    width: 95vw;
    padding: 0px;
    background-color: #F5F8FD;
    .products-list {
      margin-top: 10px;
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 10px;
      padding: 0px;
    }
    .empty-wrapper{
      font-size: 12px;
    }
  }
}
</style>
