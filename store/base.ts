import { defineStore } from "pinia";
import products from "@/assets/json/products1.json";
import type { Product } from "@/types/base";
import Fuse from 'fuse.js';

export const useBaseStore = defineStore("base", () => {
  const productAll = computed<Product[]>(() => {
    return products;
  });
  const classifyDiscountList = computed<string[]>(() => {
    return [
      "All Categories",
      "Hot selling",
      "Shoes",
      "Suit",
      "Women Clothing",
      "Hoodie",
      "Sweatshirt",
      "Sweater",
      "T-shirt",
      "Polo shirt",
      "Shorts",
      "Jacket",
      "Down Jacket",
      "Pants",
      "Jersey",
      "Samll items"
    ]
  });

  const getProductSortList = () => {
    let list = productAll.value.sort((a,b) => {
      return a.discountedPrice - b.discountedPrice
    })
    return list;
  };

  const fuseOptions = {
    keys: ['goodsTitle', 'abbr'], // 要搜索的字段
    threshold: 0.3, // 匹配阈值（0 严格，1 宽松）
    // includeMatches: true, // 包含匹配的具体位置信息
    // ignoreFieldNorm: true, // 忽略字段长度归一化
    includeScore:true
  };

  const itemsWithPinyin = productAll.value.map(p => ({
    ...p,
    abbr: p.goodsTitle.split(/\s+/).filter(Boolean).map(word => word[0].toLowerCase()).join('')
  }))

  const isAllDigits = (str:string) => {
    // 正则含义：^以数字开头，$以数字结尾，\d+匹配1个及以上数字
    return /^\d+$/.test(str);
  }
  /**
   * 商品搜索
   * @param search 名称
   * @param category 分类
   */
  const getSearchProductList = (search:string, category?:string) => {
    let list = productAll.value;
    if (category) {
       list = list.filter(
        (item: Product) => item.typeName === category
      );
    }
    if (search.trim() === '') {
      return list;
    }
    
    if (isAllDigits(search.trim())) {
      list = list.filter((item: Product) => {
        return item.offerId === search
      })
      return list;
    } else {
      const itemsWithPinyins = list.map(p => ({
        ...p,
        abbr: p.goodsTitle.split(/\s+/).filter(Boolean).map(word => word[0].toLowerCase()).join('')
      }))
      // 创建 Fuse 实例
      const fuseInstance = new Fuse(itemsWithPinyins, fuseOptions);
      const fuseResults = fuseInstance.search(search);
      return fuseResults.map(r => r.item);
    }
  }

  const getProductList = (typeName: string, category?:string) => {
    let list;
    if (typeName !== 'Storewide: 15% Off' && typeName !== 'Premium Products: 5% Off') {
      list = productAll.value.filter(
        (item: Product) => item.typeName === typeName
      );
    } else {
      list = productAll.value.filter(
        (item: Product) => item.parentTypeName === typeName
      );
    }

    if (category && category !== '') {
      list = list.filter(
        (item: Product) => item.tags.includes(category)
      );
    }

    return list;
  };

  const getIdProductInfo = (id: number) => {
    return productAll.value.find((item: Product) => {
      return (
        item.id === id
      );
    });
  }

  // 预览图片
  const previewImgsList = ref<string[]>([]);
  const previewTitleList = ref<string[]>([]);
  const curImgIndex = ref(0);
  const previewImgsVisible = ref(false);

  const setPreviewImgInfo = (list: string[], index = 0, titleArr: string[] = []) => {
    previewImgsList.value = list;
    previewTitleList.value = titleArr;
    curImgIndex.value = index;
    previewImgsVisible.value = true;
  };

  const closePreviewImg = () => {
    previewImgsList.value = [];
    previewImgsVisible.value = false;
  };

  return {
    getSearchProductList,
    getProductList,
    classifyDiscountList,
    getIdProductInfo,
    getProductSortList,

    previewImgsList,
    curImgIndex,
    previewTitleList,
    previewImgsVisible,
    setPreviewImgInfo,
    closePreviewImg,
  };
});

