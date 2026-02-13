<script setup lang="ts">
import { useBaseStore } from '~/store/base';
import JoinDiscordDialog from '@/components/dialog/JoinDiscordDialog.vue';
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
  jumpPath('/vigorbuy-spreadsheet', newQuery)
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
const showDiscord = ref(false);
const closeDiscord = () => {
    showDiscord.value = false;
}
const showDiscordSet = () => {
    showDiscord.value = true;
}
</script>

<template>
  <JoinDiscordDialog v-if="showDiscord" @onClose="closeDiscord" />
  <div class="product-detail-wrapper min-h-screen max-w-7xl mx-auto px-4 sm:!px-6 lg:!px-8 pt-8">
    <template v-if="productInfo">
      <div>
        <div class="detail-head">
          <div class="text-[13px] mb-4">
            <span class="hover:text-[#FF186B] pointer text-gray-500" @click="jumpPath('/')">
                <i class="icon iconfont icon-shouye"></i>
                <span class="ml-3">Home</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 !text-[12px] text-gray-500"></i>

            <span class="hover:text-[#FF186B] pointer text-gray-500" @click="jumpPath('/vigorbuy-spreadsheet')">
                <span class="ml-3">Spreadsheet</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 !text-[12px] text-gray-500"></i>

            <span class="hover:text-[#FF186B] pointer text-gray-500" @click="toSpreadsheetCategory(productInfo.typeName)">
                <span class="ml-3">{{ productInfo.typeName }}</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 !text-[12px] text-gray-500"></i>

            <span class="ml-5 text-white">
              {{ productInfo?.goodsTitle }}
            </span>
          </div>

          <span class="to-page text-gray-600 hover:text-[#FF186B] pointer" @click="toPage">
            <i class="icon iconfont icon-zuojiantou text-[14px]"></i>
            <span class="ml-8 text-[15px]">Back to Products</span>
          </span>
        </div>

        <div class="detail-content mt-[22px] grid lg:grid-cols-2 gap-8 mt-6">
          <div class="detail-img-wrapper">
            <div class="detail-img-cover p-[20px] rounded-[16px] border border-white/10 bg-white/5">
              <div class="img-box rounded-[10px] bg-[#F7F7F9] relative">
                <el-image fit="cover" class="product-img" loading="lazy" :src="coverImg" />
              </div>
            </div>

            <div class="mt-10">
              <div class="cover-list flex gap-[12px]">
                <div class="item border border-2 border-[#E5E7EB] p-[10px] rounded-[8px]"
                :class="{'selected !border-[#C92910]': coverIndex === index}"
                v-for="(item,index) in coverList" :key="index"
                @click="setCoverIndex(index)">
                  <el-image fit="cover" class="cover-img w-full h-full" loading="lazy" :src="item" />
                </div>
              </div>
              
              <div class="cover-text text-center mt-[15px] text-[13px] text-gray-400">
                <span>image</span>
                <span class="index text-[#c92910] bold-600">&nbsp;{{ coverIndex + 1 }}&nbsp;</span>
                <span>of</span>
                <span class="bold-600">&nbsp;{{ coverList.length }}</span>
              </div>
            </div>
          </div>

          <div class="detail-info-wrapper">
            <div class="info-basic-card p-[24px] rounded-[16px] border border-white/10 bg-white/5">
              <div class="flex gap-12 mb-4">
                <div style="height: 30px; display: flex; align-items: center; padding: 0px 15px; border-radius: 15px;background-color: #FEE7F0;color: #ff186b;">
                  <i class="icon iconfont icon-biaoqian text-[12px] bold-600"></i>
                  <span class="ml-3 text-[14px]">{{ productInfo.typeName }}</span>
                </div>

                <div style="height: 30px; display: flex; align-items: center; padding: 0px 15px;border-radius: 15px;background-color: #F3F4F6;">
                  <i class="icon iconfont icon-shouye text-[12px] bold-600"></i>
                  <span class="ml-5 text-[14px]">Weidian</span>
                </div>
              </div>

              <h1 class="text-3xl md:text-4xl font-bold mb-4 leading-tight text-white">{{ productInfo.goodsTitle }}</h1>

              <p class="text-slate-400 leading-relaxed">
                No description available for this product.
              </p>

              <div class="mt-4 pt-8 border-t border-gray-600 flex">

                <div style="width: 32px;height: 32px;border-radius: 50%;background-color: #FEE7F0;color: #ff186b;display: flex;align-items: center;justify-content: center;">
                  <i class="icon iconfont icon-fangxunrenyuan text-[14px]"></i>
                </div>

                <div class="ml-10">
                  <p class="text-[11px] text-gray-500 bold-500">Listed by</p>
                  <p class="text-[12px] bold-600 text-white">Tom and Jerry</p>
                </div>
              </div>
            </div>

            <div class="info-price-card p-[24px] rounded-[16px] mt-[20px] theme-btn-selected border border-[#ff0033]/40">
              <h3 class="text-gray-200">PRICING</h3>

              <div class="price-item flex justify-between mt-[10px] h-[35px] items-center">
                <span class="text-gray-200 text-[16px]">USD</span>
                <span class="bold-600 text-[24px]" style="color: #ff186b;">${{ productInfo.discountedPrice }}</span>
              </div>
            </div>

            <div class="info-now-buy pointer mt-[20px] h-[60px] flex items-center justify-center text-[#ffffff] rounded-[12px] theme-btn" @click="openGoods">
              <i class="icon iconfont icon-shiwu-gouwuche text-[24px] bold-500"></i>
              <span class="ml-10 bold-500 text-[19px]">Buy Now on VigorBuy</span>
            </div>

            <div class="transition hover:scale-[1.03] rounded-[8px] text-center mt-5 pt-4 pb-4 border border-[#353535] bg-white/5 text-white pointer" @click="showDiscordSet">
              <span>Join discord for more discounts</span>
            </div>

            <div class="info-detail-card mt-[20px] p-[24px] rounded-[16px] border border-white/10 bg-white/5 mb-5">
              <div class="mb-7">
                <i class="icon iconfont icon-tishi text-[16px] bold-500 text-[#ff186b]"></i>
                <span class="ml-5 bold-500 text-[16px] text-white">Product Details</span>
              </div>

              <div class="item pt-[12px] pb-[12px] flex justify-between border-gray-600 border-b text-[16px]">
                <span class="text-gray-500">Platform</span>
                <span class="bold-600 text-white">Weidian</span>
              </div>

              <div class="item pt-[12px] pb-[12px] flex justify-between border-gray-600 border-b text-[16px]">
                <span class="text-gray-500">Category</span>
                <span class="bold-600 text-white">{{ productInfo.typeName }}</span>
              </div>

              <div class="item pt-[12px] pb-[12px] flex justify-between border-gray-600 border-b text-[16px]">
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
.product-detail-wrapper{
  .detail-content{
    .detail-img-wrapper{
      .detail-img-cover{
        // border: 1px solid #E5E7EB;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
        .img-box{
          padding-bottom: 100%;
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
      .item{
        width: 119px;
        height: 119px;
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 4px 6px -1px, rgba(0, 0, 0, 0.1) 0px 2px 4px -2px;
        cursor: pointer;
        transition: transform 0.3s ease;
        &:hover{
          transform: scale(1.05);
          border-color: rgb(201, 41, 16);
        }
        .cover-img{
        }
      }
      .selected{
        transform: scale(1) !important;
      }
    }
    .cover-text{
      .index{
      }
    }
    .detail-info-wrapper{
      flex: 1;
      .info-basic-card{
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
      }
      .info-price-card{
        }
      }
      .info-now-buy{
        transition: transform 0.3s ease;
        &:hover{
          transform: scale(1.03);
          box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 8px 6px -4px;
        }
      }
      .info-detail-card{
        box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px;
        .item{
        }
      }
    }
  }
</style>
