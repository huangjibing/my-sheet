<script setup lang="ts">
import { useBaseStore } from "@/store/base";
import type { TabItem } from "@/types/base";
import {ArrowLeft, ArrowRight} from '@element-plus/icons-vue';

const route = useRoute();
const searchKey = ref(route.query.searchKey?.toString());

const baseStore = useBaseStore();
const sort = ref(false);
const productList = ref(
  searchKey.value ? baseStore.getSearchList(searchKey.value) : []
);

const showScrollbar = ref(false);

const curKey = ref("");
const tabList = computed<TabItem[]>(() => {
  const arr: TabItem[] = [];
  const arrMap = new Map();
  productList.value.forEach((item) => {
    if (!arrMap.has(item.typeName)) {
      arr.push({
        key: item.typeName,
        label: item.typeName,
      });
      arrMap.set(item.typeName, true);
    }
  });
  return arr;
});
const pageSize = ref(1);

const router = useRouter();
const handleInit = (txt?: string) => {
  pageSize.value = 1;
  if (txt) {
    searchKey.value = txt;
    productList.value = baseStore.getSearchList(searchKey.value);
  } else if (!searchKey.value) {
    productList.value = [];
  } else {
    productList.value = baseStore.getSearchList(searchKey.value);
  }
  if (productList.value.length) {
    curKey.value = productList.value[0].typeName;
  } else {
    curKey.value = "";
  }
  router.replace({
    query: {
      searchKey: searchKey.value,
    },
  });
};
handleInit();

watch(
  () => route.query.searchKey,
  async (newKeyword) => {
    const keyword1: string = String(newKeyword || '');
    handleInit(keyword1);
    await nextTick();
    hasHorizontalScrollbar();
  }
)

const productTypeList = computed(() => {
  let list = productList.value.filter((item) => item.typeName === curKey.value);
  list.sort((a, b) => {
    return sort.value === false ? a.discountedPrice - b.discountedPrice : b.discountedPrice - a.discountedPrice
  })
  return list;
});

const productCurList = computed(() => {
  return productTypeList.value.slice(0, pageSize.value * 40);
});

const handleChangeKey = (key: string) => {
  curKey.value = key;
  pageSize.value = 1;
};

const handleScroll = (e: any) => {
  if (!e.target) return;
  const { scrollTop, clientHeight, scrollHeight } = e.target.scrollingElement;
  if (
    scrollTop + clientHeight + 10 >= scrollHeight
  ) {
    pageSize.value += 1;
  }
};

onMounted(async () => {
  await nextTick();
  hasHorizontalScrollbar();
  window.addEventListener("scroll", handleScroll)
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll)
});

const right = ref(false);
const scrollWrapperRef = ref();

const hasHorizontalScrollbar = () => {
  right.value = false;
  if (scrollWrapperRef.value) {
    showScrollbar.value =  scrollWrapperRef.value.scrollWidth > scrollWrapperRef.value.clientWidth;
  } else {
    showScrollbar.value = false;
  }
}

const direction = (dir:boolean) => {
  right.value = dir;
  if (dir) {
    scrollWrapperRef.value.scrollLeft = scrollWrapperRef.value.scrollWidth - scrollWrapperRef.value.clientWidth;
  } else {
    scrollWrapperRef.value.scrollLeft = 0;
  }
}

const sortClick = () => {
  pageSize.value = 1;
  sort.value = !sort.value;
  productList.value = searchKey.value ? baseStore.getSearchList(searchKey.value) : [];
}
</script>

<template>
  <div class="filter">
    <div class="fillter-box" @click="sortClick()">
      <span class="text">Price</span>
       <span class="jt">{{ sort == false ? '▼' : '▲' }}</span>
    </div>
  </div>
  <div class="search-wrapper">
    <div class="goods">
      <div class="tab-left" @click="direction(false)" v-show="right && showScrollbar">
        <el-icon><ArrowLeft /></el-icon>
      </div>

       <div class="tab-right" @click="direction(true)" v-show="!right && showScrollbar">
          <el-icon><ArrowRight /></el-icon>
        </div>
      <div class="goods-tab" ref="scrollWrapperRef">

        <div @click="handleChangeKey(item.key + '')" class="tab" :class="{'active': curKey === item.key}" v-for="item in tabList" :key="item.key">
          {{item.key}}
        </div>
      </div>

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
  </div>
</template>

<style lang="scss" scoped>
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
.search-wrapper{
  .goods{
    // background-color: #ffffff;
    background: #F5F6FA;
    border-radius: 20px;
    margin-top: 20px;
    width: 1400px;
    padding: 20px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    .tab-left{
      position: absolute;
      left: 12px;
      height: 32px;
      line-height: 32px;
      padding: 0px 10px;
      background-color: #ffffff;
      border-radius: 4px;
      border: 1px solid rgb(197, 181, 181);
      cursor: pointer;
      // box-shadow: 0px 0px 0px 20px rgba($color: #eee6e6, $alpha: 1.0);
      &:hover{
        background: #F5F8FD;
      }
    }
    .tab-right{
      position: absolute;
      right: 12px;
      height: 32px;
      line-height: 32px;
      padding: 0px 10px;
      background-color: #ffffff;
      border-radius: 4px;
      border: 1px solid rgb(197, 181, 181);
      cursor: pointer;
      box-shadow: 0 0 10px 10px #ffffff;
      // pointer-events: none; /* 避免影响元素交互 */
      &:hover{
        background: #F5F8FD;
      }
    }
    .goods-tab::-webkit-scrollbar {
      display: none;
    }
    .goods-tab{
      display: flex;
      overflow-x: auto;
      // position: relative;
      .tab{
          padding: 4px 18px;
          color: #333;
          font-feature-settings: 'liga' off, 'clig' off;
          font-size: 16px;
          font-style: normal;
          font-weight: 400;
          border-radius: 8px;
          background: #F5F8FD;
          cursor: pointer;
          white-space: nowrap;
          &.active{
            background: #FF2E38;
            color: #FFF;
            font-feature-settings: 'liga' off, 'clig' off;
            font-size: 16px;
            font-style: normal;
            font-weight: 700;
          }
        }
        .tab:not(:first-child){
          margin-left: 10px;
        }
      }
    .products-list {
      margin-top: 20px;
      display: grid;
      grid-template-columns: repeat(5, 1fr);
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
}

@media screen and (max-width: 1024px) {
  .search-products-list {
    padding: 24px 32px 64px;
    gap: 32px;
    grid-template-columns: repeat(3, 1fr);
  }
}
@media screen and (max-width: 768px) {
  .filter{
    width: 95vw;
    .fillter-box{
      background-color: transparent;
      padding: 0px;
    }
  }
  .search-wrapper {
    .goods{
      width: 95vw;
      margin-top: 10px;
      padding: 0px;
      .tab-left{
        display: none;
      }
      .tab-right{
        display: none;
      }
      .goods-tab{
        .tab{
          padding: 2px 9px;
          font-size: 14px;
          &.active{
            font-size: 14px;
          }
        }
      }
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
}
</style>
