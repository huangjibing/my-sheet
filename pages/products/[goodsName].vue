<script setup lang="ts">
import { useBaseStore } from "@/store/base";
import type { Product } from '~/types/base';

const route = useRoute();
const router = useRouter();
const goodsName = route.params.goodsName.toString();

const baseStore = useBaseStore();

const inviteCode = ref("");
onMounted(() => {
  inviteCode.value =
    route.query.inviteCode?.toString() ||
    localStorage.getItem("inviteCode") ||
    "";
});

const openGoods = () => {
  if (inviteCode.value) {
    openLink(`${productInfo.value?.vigorbuyUrl}?inviteCode=${inviteCode.value}&utm_source=vigorbuysheet`)
  } else {
    openLink(`${productInfo.value?.vigorbuyUrl}?utm_source=vigorbuysheet`)
  }
  window?.fbq?.('track', 'ViewContent');
}

const toPage = () => {
  router.go(-1);
}

const productInfo = ref<Product>();
const coverList = ref<string[]>([]);
const coverIndex = ref(0);
const setCoverIndex = (index:number) => {
  if (index !== coverIndex.value) {
    coverIndex.value = index;
  }
}

const toSpreadsheetCategory = (category:string) => {
  const newQuery = {
    category
  }
  jumpPath('/vigorbuybuy-spreadsheet', newQuery)
}
onMounted(() => {
  productInfo.value = baseStore.getIdProductInfo(parseInt(goodsName));
  coverList.value = [productInfo.value?.image || ''].concat(productInfo.value?.qcImage || []);
})
const coverImg = computed(() => {
  return coverList.value[coverIndex.value]
});

</script>

<template>
  <div class="product-detail-wrapper max-w-7xl mx-auto px-4 sm:!px-6 lg:!px-8 pt-8">
    <template v-if="productInfo">
      <div>
        <div class="detail-head">
          <div class="font-13">
            <span class="home text-gray-500" @click="jumpPath('/')">
                <i class="icon iconfont icon-shouye"></i>
                <span class="ml-3">Home</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 font-12 text-gray-500"></i>

            <span class="home text-gray-500" @click="jumpPath('/vigorbuybuy-spreadsheet')">
                <span class="ml-3">Spreadsheet</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 font-12 text-gray-500"></i>

            <span class="home text-gray-500" @click="toSpreadsheetCategory(productInfo.typeName)">
                <span class="ml-3">{{ productInfo.typeName }}</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 font-12 text-gray-500"></i>

            <span class="ml-5">
              {{ productInfo?.goodsTitle }}
            </span>
          </div>

          <div class="mt-8 to-page text-gray-600" @click="toPage">
            <i class="icon iconfont icon-zuojiantou font-14"></i>
            <span class="ml-8 font-15">Back to Products</span>
          </div>
        </div>

        <div class="detail-content grid lg:grid-cols-2 gap-8 mt-6">

          <div class="detail-img-wrapper">
            <div class="detail-img-cover">
              <div class="img-box">
                <el-image fit="cover" class="product-img" loading="lazy" :src="coverImg" />
              </div>
            </div>

            <div class="mt-10">
              <div class="cover-list">
                <div class="item"
                :class="{'selected': coverIndex === index}"
                v-for="(item,index) in coverList" :key="index"
                @click="setCoverIndex(index)">
                  <el-image fit="cover" class="cover-img" loading="lazy" :src="item" />
                </div>
              </div>
              
              <div class="cover-text">
                <span>image</span>
                <span class="index bold-600">&nbsp;{{ coverIndex + 1 }}&nbsp;</span>
                <span>of</span>
                <span class="bold-600">&nbsp;{{ coverList.length }}</span>
              </div>
            </div>
          </div>

          <div class="detail-info-wrapper">
            <div class="info-basic-card">
              <div class="flex gap-12">
                <div style="height: 30px; display: flex; align-items: center; padding: 0px 15px; border-radius: 15px;background-color: #FEE7F0;color: #ff186b;">
                  <i class="icon iconfont icon-biaoqian font-12 bold-600"></i>
                  <span class="ml-3 font-14">{{ productInfo.typeName }}</span>
                </div>

                <div style="height: 30px; display: flex; align-items: center; padding: 0px 15px;border-radius: 15px;background-color: #F3F4F6;">
                  <i class="icon iconfont icon-shouye font-12 bold-600"></i>
                  <span class="ml-5 font-14">Weidian</span>
                </div>
              </div>

              <h1 class="mt-16">{{ productInfo.goodsTitle }}</h1>

              <div class="mt-16">
                No description available for this product.
              </div>

              <div class="mt-16 pt-16 border-t border-gray-100 flex">

                <div style="width: 32px;height: 32px;border-radius: 50%;background-color: #FEE7F0;color: #ff186b;display: flex;align-items: center;justify-content: center;">
                  <i class="icon iconfont icon-fangxunrenyuan font-14"></i>
                </div>

                <div class="ml-10">
                  <p class="font-11 text-gray-500 bold-500">Listed by</p>
                  <p class="font-12 bold-600">manyouyisi</p>
                </div>
              </div>
            </div>

            <div class="info-price-card">
              <h3 class="text-gray-700">PRICING</h3>

              <div class="price-item">
                <span class="text-gray-700 font-16">USD</span>
                <span class="bold-600 font-24" style="color: #ff186b;">${{ productInfo.discountedPrice }}</span>
              </div>
            </div>

            <div class="info-now-buy" @click="openGoods">
              <i class="icon iconfont icon-shiwu-gouwuche font-24 bold-500"></i>
              <span class="ml-10 bold-500 font-18">Buy Now on VigorBuy</span>
            </div>

            <div class="info-detail-card">
              <div class="mb-7">
                <i class="icon iconfont icon-tishi font-16 bold-500 text-ff186b"></i>
                <span class="ml-5 bold-500 font-16">Product Details</span>
              </div>

              <div class="item border-gray-100 border-b font-16">
                <span class="text-gray-600">Platform</span>
                <span class="bold-600">Weidian</span>
              </div>

              <div class="item border-gray-100 border-b font-16">
                <span class="text-gray-600">Category</span>
                <span class="bold-600">{{ productInfo.typeName }}</span>
              </div>

              <div class="item border-gray-100 border-b font-16">
                <span class="text-gray-600">Product ID</span>
                <span class="bold-600">{{ productInfo.offerId }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
    <template v-else>Product not found</template>
  </div>
</template>

<style lang="scss" scoped>
.home{
    cursor: pointer;
    &:hover{
        color: #FF186B;
    }
}
.text-ff186b{
  color: #ff186b;
}
.product-detail-wrapper{
  .to-page{
    line-height: 24px;
    display: inline-block;
    &:hover{
      color: rgb(201, 41, 16);
      cursor: pointer;
    }
  }
  .detail-content{
    margin-top: 22px;
    .detail-img-wrapper{
      .detail-img-cover{
        border: 1px solid #E5E7EB;
        padding: 20px;
        border-radius: 16px;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
        .img-box{
          padding: 0px;
          border-radius: 10px;
          background-color: #F7F7F9;
          padding-bottom: 100%;
          position: relative; 
        }
        .product-img{
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          justify-content: center;
        }
      }
    }
    .cover-list{
      display: flex;
      gap: 12px;
      .item{
        border: 2px solid #E5E7EB;
        padding: 10px;
        width: 119px;
        height: 119px;
        border-radius: 8px;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 4px 6px -1px, rgba(0, 0, 0, 0.1) 0px 2px 4px -2px;
        cursor: pointer;
        transition: transform 0.3s ease;
        &:hover{
          transform: scale(1.05);
          border-color: rgb(201, 41, 16);
        }
        .cover-img{
          width: 100%;
          height: 100%;
        }
      }
      .selected{
        border-width: 2px;
        background-color: #F9E9E7;
        border-color: rgb(201, 41, 16);
        transform: scale(1) !important;
      }
    }
    .cover-text{
      margin-top: 15px;
      text-align: center;
      font-size: 13px;
      .index{
        color: #c92910;
      }
    }
    .detail-info-wrapper{
      flex: 1;
      .info-basic-card{
        padding: 24px;
        border: 1px solid #E5E7EB;
        border-radius: 16px;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
      }
      .info-price-card{
        padding: 24px;
        background-image: linear-gradient(to right bottom, lab(55.8824 81.016 18.8158 / 0.05) 0%, lab(97.1627 2.99937 -4.13398) 50%, lab(96.4459 4.53997 -1.49434) 100%);
        border-radius: 16px;
        margin-top: 20px;
        .price-item{
          display: flex;
          justify-content: space-between;
          margin-top: 10px;
          height: 35px;
          align-items: center;
        }
      }
      .info-now-buy{
        margin-top: 20px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-image: linear-gradient(to right, rgb(255, 24, 107) 0%, #C40003 100%);
        color: #fff;
        border-radius: 12px;
        cursor: pointer;
        transition: transform 0.3s ease;
        &:hover{
          transform: scale(1.03);
          box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 8px 6px -4px;
        }
      }
      .info-detail-card{
        margin-top: 20px;
        padding: 24px;
        border: 1px solid #E5E7EB;
        border-radius: 16px;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
        .item{
          padding: 12px 0px;
          display: flex;
          justify-content: space-between;
        }
      }
    }
  }
}

@media screen and (max-width: 768px) {
  .product-detail-wrapper {
    // flex-direction: column-reverse;
    // padding: 32px 24px 64px;
    // flex-direction: column;
    .detail-content{
      // flex-direction: column;
    }
  }
  .product-img {
    max-width: 100%;
    height: 326px;
  }
  .product-info{
    width: 100%;
    text-align: left;
  }
  .product-title{
    justify-content: left;
    margin-top: 0px;
    .tag{
      height: 15px;
      line-height: 15px;
      font-size: 11px;
    }
    .product-title-h1{
      font-size: 17px;
      line-height: 15px;
    }
  }
  .product-price{
    margin-top: 0px;
    justify-content: left;
    .discount{
      .price{
        font-size: 30px;
        .symbol{
          font-size: 20px;
        }
        .decimal{
          font-size: 30px;
        }
      }
      .original{
        font-size: 15px;
        font-weight: 400;
        text-decoration: line-through;
      }
    }
  }
  .product-code{
    margin-top: 10px;
    margin-left: 0px;
    margin-right: 0px;
  }
  .open-btn{
    margin: 10px auto;
    width: 100%;
    height: 46px;
    line-height: 46px;
    font-size: 17px;
  }
  .qc-wrapper{
    margin-top: 0px;
  }
  .qc-list {
    margin-top: 16px;
    grid-template-columns: repeat(1, 1fr);
  }
  .products-list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 10px;
    padding: 0px;
  }
}
</style>
