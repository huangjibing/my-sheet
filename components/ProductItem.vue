<script setup lang="ts">
import type { Product } from "~/types/base";
import { useBaseStore } from '~/store/base';

const baseStore = useBaseStore();

interface Props {
  productInfo: Product;
}

const props = defineProps<Props>();

const route = useRoute();
const inviteCode = ref("");
const handleGoProductDetail = (id: number) => {
  jumpPath(`/products/${id}`, route.query)
  // window?.fbq?.('track', 'ViewContent');
};

const priceArr = (price:string) => {
  return price.split('.');
};
const version = ref(1);

onMounted(() => {
  inviteCode.value =
    route.query.inviteCode?.toString() ||
    localStorage.getItem("inviteCode") ||
    "";
})
</script>

<template>
  <div
    class="product-item"
    @click="handleGoProductDetail(productInfo.id)"
  >
    <div>
      <div class="product-img-wrapper">
        <el-image fit="cover" class="product-img" loading="lazy" :src="productInfo.image + `?v=${version}`" />
        <div class="product-tag">
          <div class="qc" @click.stop="baseStore.setPreviewImgInfo(productInfo.qcImage)">
            <i class="icon iconfont icon-biaoqian font-11"></i>
            <span>
              {{ productInfo.typeName }}
            </span>
          </div>
          <div class="source">
            Weidian
          </div>
        </div>
        <div class="product-overlay"></div>
      </div>

      <div class="product-info">
        <div class="info-text">
          <h3 class="text-gray-900 wrap-line-2">{{ productInfo.goodsTitle }}</h3>
          <p class="text-gray-600 font-13 mt-8">No description available</p>
          <p class="text-gray-600 font-13 mt-8">
            <i class="icon iconfont icon-fangxunrenyuan"></i>
            <span class="ml-3">manyouyisi</span>
          </p>
        </div>
      </div>

      <div class="product-price">
        <p class="text-gray-500 font-13">Price</p>
        <div class="mt-5">
          <span class="discountedPrice">
            <span class="symbol">$</span>
            <span class="">{{priceArr(productInfo.discountedPrice + '')[0] }}</span>
            <span class="decimal" v-show="priceArr(productInfo.discountedPrice + '')[1]">.{{priceArr(productInfo.discountedPrice + '')[1] }}</span>
          </span>
        </div>
      </div>
    </div>
    <!-- 300*300 占位图 -->
    <div class="buy-btn">
      <span>Buy Now</span>
      <i class="icon iconfont icon-tiaozhuan font-13 ml-5"></i>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.el-rate{
  --el-rate-icon-margin: 1px;
  height: auto;
}
.product-item {
  cursor: pointer;
  background-color: #fff;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  &:hover{
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5); /* 阴影增强 */
    .product-img{
      transform: scale(1.05); /* 轻微放大 */
    }
    .product-info{
      h3{
        color: #ff186b !important;
      }
    }
    .product-overlay{
      display: block;
    }
  }
  .product-img-wrapper {
    max-width: min(100%, 100%);
    padding-bottom: 236px;
    position: relative;
    margin: auto;
    overflow: hidden;
  }
  .product-img {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    object-fit: contain;
    width: 100%;
    height: 100%;
    vertical-align: top;
    transition: all 0.3s ease;
  }
  .product-qcimg{
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    object-fit: contain;
    width: 100%;
    height: 100%;
    vertical-align: top;
    transition: all 0.3s ease;
    display: none;
  }
  .product-overlay{
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    /* 底部渐变遮罩 */
    background: linear-gradient(to top, rgba(0,0,0,0.35), transparent);
    color: #fff;
    height: 40%;
    display: none;
  }
  .product-tag{
    display: flex;
    justify-content: space-between;
    position: relative;
    top: 8px;
    margin: 0px 10px;
    .qc{
      height: 20px;
      padding: 0px 10px;
      border-radius: 10px;
      font-size: 12px;
      display: flex;
      align-items: center;
      color: #ff186b;
      cursor: pointer;
      background-color: #fff;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.5); /* 阴影增强 */
      font-weight: 600;
      vertical-align: middle;
      line-height: 1;
      gap: 3px;
    }
    .source{
      height: 20px;
      line-height: 20px;
      background-color: #000;
      border-radius: 3px;
      color: #fff;
      padding: 0px 5px;
      font-size: 12px;
    }
  }
  .product-info{
    margin-top: 20px;
    margin-left: 15px;
    margin-right: 15px;
    .info-text{
      border-bottom: 1px solid rgba(23, 23, 23, 0.05);
      padding-bottom: 15px;
    }
  }
  .product-price{
    padding: 10px 15px;
    font-size: 18px;
    padding-bottom: 10px;
    .price{
      color: #999;
      font-size: 15px;
      text-decoration: line-through;
      margin-left: 3px;
    }
    .discountedPrice{
      font-size: 24px;
      color: #FF0039;
      margin-left: 3px;
      font-family: "PuHuiTiBold";
      .symbol{
        font-size: 20px;
      }
      .decimal{
        font-size: 18px;
      }
    }
  }
  .buy-btn{
    border-radius: 8px;
    background: linear-gradient(to right, rgb(255, 24, 107) 0%, lab(40.4273 67.2623 53.7441) 100%); /* 粉到红渐变 */
    font-size: 14px;
    font-weight: 700;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 10px 15px;
    height: 40px;
    transition: transform 0.3s ease;
    &:hover{
      transform: scale(1.05); /* 轻微放大 */
    }
  }
}
@media screen and (max-width: 768px) {
  .product-item{
    .product-img-wrapper {
      padding-bottom: 10rem;
    }
    .product-price{
      .price{
        margin-top: 2px;
        font-size: 14px;
      }
      .discountedPrice{
        font-size: 20px;
        .ymbol{
          font-size: 16px;
        }
        .decimal{
          font-size: 15px;
        }
      }
    }
    .buy-btn{
      text-align: center;
      margin: 10px;
      margin-top: 5px;
      height: 30px;
    }
  }
}
</style>
