<script setup lang="ts">
import { useBaseStore } from "@/store/base";
import type { TabItem } from "@/types/base";

const baseStore = useBaseStore();

const openLink = (url: string, target = '_blank') => {
   const a = document.createElement('a');
    a.setAttribute('href', url);
    a.setAttribute('target', target);
    a.setAttribute('id', 'camnpr');
    document.body.appendChild(a);
    a.click();
};


const pageSize = ref(1);
const productList = computed(() => {
  return baseStore.getProductList(curKey.value, lastCategory.value != 'All' ? lastCategory.value : firstCategory.value);
});

const productCurList = computed(() => {
  return productList.value.slice(0, pageSize.value * 40);
});

const handleScroll = (e: any) => {
  // if (!e.target) return;
  // const c = e.target as HTMLElement;
  // const { scrollTop, clientHeight, scrollHeight } = c;
  // if (
  //   scrollTop + clientHeight + 10 >= scrollHeight &&
  //   productList.value.length > productCurList.value.length
  // ) {
  //   pageSize.value += 1;
  // }

  if (!e.target) return;
  const { scrollTop, clientHeight, scrollHeight } = e.target.scrollingElement;
  if (
    scrollTop + clientHeight + 10 >= scrollHeight
  ) {
    pageSize.value += 1;
  }
};
const version = ref(1);
onMounted(async () => {
  // document.getElementsByClassName('main-content')[0].addEventListener("scroll", handleScroll)
  window.addEventListener("scroll", handleScroll);
  version.value++;
});

onUnmounted(() => {
  // document.getElementsByClassName('main-content')[0].removeEventListener("scroll", handleScroll)
  window.removeEventListener("scroll", handleScroll)
});

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

const firstCategory = ref('');
const lastCategory = ref('');
const onSelect = (first:string, last:string) => {
  pageSize.value = 1;
  firstCategory.value = first;
  lastCategory.value = last;
}

const curKey = ref('Storewide: 15% Off')
const tabList = computed<TabItem[]>(() => {
  const arr: TabItem[] = [];
  
  baseStore.discountList.forEach((item) => {
    arr.push({
      key: item.key,
      label: item.label,
    });
  });
  return arr;
});
const handleChangeKey = (key:string) => {
  pageSize.value = 1;
  curKey.value = key;
}
</script>

<template>
  <div class="home-wrappers">
    <HomeMs />
  </div>
</template>

<style lang="scss" scoped>
.home-wrappers{
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
  .home-banner{
    width: 1220px;
    margin-left: auto;
    margin-right: auto;
    .img{
      width: 100%;
      height: 280px;
    }
  }
  .goods{
    // background-color: #ffffff;
    background: #F5F6FA;
    border-radius: 20px;
    margin-top: 20px;
    width: 1440px;
    padding: 20px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    .tab-left{
      position: absolute;
      left: 12px;
      top: 87px;
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
      top: 87px;
      line-height: 32px;
      padding: 0px 10px;
      background-color: #ffffff;
      border-radius: 4px;
      border: 1px solid rgb(197, 181, 181);
      cursor: pointer;
      box-shadow: 0 0 10px 10px #ffffff;
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
      margin-top: 10px;
      // position: relative;
      .tab{
          padding: 4px 14px;
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
            background: #000;
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
      margin-top: 10px;
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

@media screen and (max-width: 1600px) {

}

@media screen and (max-width: 768px) {
  ::v-deep .el-carousel__indicators--horizontal {
    height: 30px;
  }
  .home-wrappers{
    width: 100vw;
    // overflow-x: hidden;
    margin-top: 0px;
    .home-ategory{
      width: 100vw;
      overflow-y: hidden;
      overflow-x: auto;
      height: 50px;
      background-color: #F5F8FD;
      position: sticky;
      top: 45px;
    }
    .home-ategory::-webkit-scrollbar {
      height: 0;
    }
    .home-banner{
      width: 95vw;
      .img{
        width: 95vw;
        height: 88px;
      }
    }
    .goods{
      width: 95vw;
      margin-top: 8px;
      padding: 0px;
      background-color: #F5F8FD;
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
