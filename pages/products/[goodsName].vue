<script setup lang="ts">
import { useBaseStore } from '~/store/base';
const route = useRoute();
const router = useRouter();
const goodsName = route.params.goodsName.toString();
const baseStore = useBaseStore();

const inviteCode = ref("");
onMounted(() => {
  inviteCode.value =
    route.query.inviteCode?.toString() ||
    localStorage.getItem("inviteCode") ||
    "bkwNqLO7";
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

const productInfo = ref<any>();
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
const loading = ref(true);
onMounted(() => {
  let productInfos = baseStore.getIdProductInfo(parseInt(goodsName));
  if (productInfos) {
    productInfo.value = productInfos;
    coverList.value = [productInfo.value?.image || ''].concat(productInfo.value?.qcImage || []);
    loading.value = false;
  } else {
    queryDataByKey("productDB", "products", parseInt(goodsName)).then(data => {
      productInfo.value = data;
      coverList.value = [productInfo.value?.image || ''].concat(productInfo.value?.qcImage || []);
    }).finally(() => {
      loading.value = false;
    })
  }
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
          <div class="font-13 mb-4">
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

            <span class="ml-5 text-white">
              {{ productInfo?.goodsTitle }}
            </span>
          </div>

          <div class="to-page text-gray-600" @click="toPage">
            <i class="icon iconfont icon-zuojiantou font-14"></i>
            <span class="ml-8 font-15">Back to Products</span>
          </div>
        </div>

        <div class="detail-content grid lg:grid-cols-2 gap-8 mt-6">
          <div class="detail-img-wrapper">
            <div class="detail-img-cover border border-white/10 bg-white/5">
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
              
              <div class="cover-text text-gray-400">
                <span>image</span>
                <span class="index bold-600">&nbsp;{{ coverIndex + 1 }}&nbsp;</span>
                <span>of</span>
                <span class="bold-600">&nbsp;{{ coverList.length }}</span>
              </div>
            </div>
          </div>

          <div class="detail-info-wrapper">
            <div class="info-basic-card border border-white/10 bg-white/5">
              <div class="flex gap-12 mb-4">
                <div style="height: 30px; display: flex; align-items: center; padding: 0px 15px; border-radius: 15px;background-color: #FEE7F0;color: #ff186b;">
                  <i class="icon iconfont icon-biaoqian font-12 bold-600"></i>
                  <span class="ml-3 font-14">{{ productInfo.typeName }}</span>
                </div>

                <div style="height: 30px; display: flex; align-items: center; padding: 0px 15px;border-radius: 15px;background-color: #F3F4F6;">
                  <i class="icon iconfont icon-shouye font-12 bold-600"></i>
                  <span class="ml-5 font-14">Weidian</span>
                </div>
              </div>

              <h1 class="text-3xl md:text-4xl font-bold mb-4 leading-tight text-white">{{ productInfo.goodsTitle }}</h1>

              <p class="text-slate-400 leading-relaxed">
                No description available for this product.
              </p>

              <div class="mt-4 pt-8 border-t border-gray-600 flex">

                <div style="width: 32px;height: 32px;border-radius: 50%;background-color: #FEE7F0;color: #ff186b;display: flex;align-items: center;justify-content: center;">
                  <i class="icon iconfont icon-fangxunrenyuan font-14"></i>
                </div>

                <div class="ml-10">
                  <p class="font-11 text-gray-500 bold-500">Listed by</p>
                  <p class="font-12 bold-600 text-white">manyouyisi</p>
                </div>
              </div>
            </div>

            <div class="info-price-card inset-0 bg-gradient-to-r from-[#ff3eaa]/20 to-[#008cff]/20 rounded-full border border-[#ff3eaa]/40">
              <h3 class="text-gray-200">PRICING</h3>

              <div class="price-item">
                <span class="text-gray-200 font-16">USD</span>
                <span class="bold-600 font-24" style="color: #ff186b;">${{ productInfo.discountedPrice }}</span>
              </div>
            </div>

            <div class="info-now-buy inset-0 bg-gradient-to-r from-[#ff3eaa] to-[#008cff] rounded-full" @click="openGoods">
              <i class="icon iconfont icon-shiwu-gouwuche font-24 bold-500"></i>
              <span class="ml-10 bold-500 font-18">Buy Now on VigorBuy</span>
            </div>

            <div class="info-detail-card border border-white/10 bg-white/5">
              <div class="mb-7">
                <i class="icon iconfont icon-tishi font-16 bold-500 text-ff186b"></i>
                <span class="ml-5 bold-500 font-16 text-white">Product Details</span>
              </div>

              <div class="item border-gray-600 border-b font-16">
                <span class="text-gray-500">Platform</span>
                <span class="bold-600 text-white">Weidian</span>
              </div>

              <div class="item border-gray-600 border-b font-16">
                <span class="text-gray-500">Category</span>
                <span class="bold-600 text-white">{{ productInfo.typeName }}</span>
              </div>

              <div class="item border-gray-600 border-b font-16">
                <span class="text-gray-500">Product ID</span>
                <span class="bold-600 text-white">{{ productInfo.offerId }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
    <!-- <template v-else>Product not found</template> -->
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
  min-height: 100vw;
  min-height: 100vh;
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
        // border: 1px solid #E5E7EB;
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
        border-radius: 16px;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
      }
      .info-price-card{
        padding: 24px;
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
