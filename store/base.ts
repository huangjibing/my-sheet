import { defineStore } from "pinia";
import products from "@/assets/json/products1.json";
import type { Product } from "@/types/base";
import Fuse from 'fuse.js';
import { pinyin }from 'pinyin-pro';
import type { TabItem } from "@/types/base";

export const useBaseStore = defineStore("base", () => {
  const productAll = computed<Product[]>(() => {
    return products;
  });
  const classifyList = computed<string[]>(() => {
    // const set: Set<string> = new Set();
    // products.forEach((item: Product) => {
    //   set.add(item.typeName);
    // });
    // return Array.from(set);
    return [
      "Hot seller",
      "Shoes",
      "Slippers",
      "Suit",
      "Sweatshirt",
      "Hoodie",
      "Sweater",
      "T-shirt",
      "Polo shirt",
      "Shorts",
      "Jacket",
      "Pants",
      "Underwear",
      "Down Jacket",
      "Belt",
      "Jersey",
      "Hat",
      "Wallet",
      "Sunglasses",
      "Accessories",
      "Scarf",
      "Bag",
      "Electronics",
      "Socks",
      "Perfume",
    ];
  });
  const classifyDiscountList = computed<string[]>(() => {
    return [
      "All Categories",
      "Hot selling",
      "Shoes",
      "Suit",
      "Women clothes",
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

  const discountList = computed<TabItem[]>(() => {
    return [
      // {
      //   label: '30% Off',
      //   key: 'Popular: 30% Off'
      // },
      // {
      //   label: '50% Off',
      //   key: 'Surprise: From 50% Off'
      // },
      {
        label: '15% Off',
        key: 'Storewide: 15% Off'
      },
      {
        label: '5% Off',
        key: 'Premium Products: 5% Off'
      },
      // {
      //   label: '80% Off',
      //   key: 'Insane Deals: 80% Off'
      // }
    ]
  })

  const getProductSortList = () => {
    let list = productAll.value.sort((a,b) => {
      return a.discountedPrice - b.discountedPrice
    })
    return list;
  };

  /**
   * 随机打乱数组顺序（Fisher-Yates 算法）
   * @param {Array} arr - 要打乱的数组
   * @returns {Array} 打乱后的新数组（不修改原数组）
   */
  function shuffleArray(arr:any) {
    // 复制原数组，避免修改原数组
    const newArr = [...arr];
    for (let i = newArr.length - 1; i > 0; i--) {
      // 生成 [0, i] 之间的随机索引
      const j = Math.floor(Math.random() * (i + 1));
      // 交换元素
      [newArr[i], newArr[j]] = [newArr[j], newArr[i]];
    }
    return newArr;
  }

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

  /**
   * 分类查询
   * @param category 分类名称
   * @returns 
   */
  const getProductCategory = (category: string) => {
    const list = productAll.value.filter(
      (item: Product) => item.tags.includes(category)
    );

    return shuffleArray(list);
  }


  /**
   * 品牌商品查詢并排序
   * @param brandName 
   * @returns 
   */
  const getProductBrandSortList = (brandName: string, category?:string) => {
    let list = productAll.value.filter(
      (item: Product) => item.brand === brandName
    );

    if (category && category !== '') {
      list = list.filter(
        (item: Product) => item.tags.includes(category)
      );
    }

    list.sort((a,b) => {
      return a.discountedPrice - b.discountedPrice
    })
    return list;
  }

  const getProductTypeSortList = (typeName: string, category?:string) => {
    let list = productAll.value.filter(
      (item: Product) => item.typeName === typeName
    );

    if (category && category !== '') {
      list = list.filter(
        (item: Product) => item.tags.includes(category)
      );
    }

    list.sort((a,b) => {
      return a.discountedPrice - b.discountedPrice
    })
    return list;
  };

  const getProducParentTypetList = (typeName: string) => {
    let list = productAll.value.filter(
      (item: Product) => item.parentTypeName === typeName
    );
    list.sort((a,b) => {
      return a.discountedPrice - b.discountedPrice
    })
    return list;
  };

  const getProducParentTypetListRandom = (typeName: string) => {
    let list = productAll.value.filter(
      (item: Product) => item.parentTypeName === typeName
    );
    return shuffleArray(list);
  };

  const getSearchList = (searchKey: string) => {
    // const keyArr = searchKey.toLowerCase().split(" ");
    // const list =
    //   productAll.value.filter((item: Product) => {
    //     return keyArr.some(
    //       (key: string) =>
    //         key.trim() && item.goodsTitle.toLowerCase().includes(key.trim())
    //     );
    //   }) || [];
    // list.sort((a: Product, b: Product) => {
    //   const aCount = keyArr.reduce((pre: number, cur: string) => {
    //     if (cur.trim() && a.goodsTitle.toLowerCase().includes(cur.trim())) {
    //       pre++;
    //     }
    //     return pre;
    //   }, 0);

    //   const bCount = keyArr.reduce((pre: number, cur: string) => {
    //     if (cur.trim() && b.goodsTitle.toLowerCase().includes(cur.trim())) {
    //       pre++;
    //     }
    //     return pre;
    //   }, 0);

    //   return bCount - aCount;
    // });

    // let list = JSON.parse(JSON.stringify(productAll.value));
    // for(let i in keyArr) {
    //   list = list.filter((item: Product) => {
    //     return item.goodsTitle.toLowerCase().includes(keyArr[i].trim())
    //   })
    // }
    // list.sort((a:Product,b:Product) => {
    //   return a.discountedPrice - b.discountedPrice;
    // })
    // return list;
    if (isAllDigits(searchKey.trim())) {
      const list = productAll.value.filter((item: Product) => {
        return item.offerId === searchKey
      })
      return list;
    } else {
      // 创建 Fuse 实例
      const fuseInstance = new Fuse(itemsWithPinyin, fuseOptions);
      const fuseResults = fuseInstance.search(searchKey);
      return fuseResults.map(r => r.item);
    }
  };

  const getProductInfo = (goodsTitle: string) => {
    console.log(
      productAll.value[0].goodsTitle
        .replaceAll(" ", "-")
        .replace(/[#()&]/g, "") === goodsTitle,
      productAll.value[0].goodsTitle
        .replaceAll(" ", "-")
        .replace(/[#()&\n]/g, ""),
      goodsTitle
    );
    return productAll.value.find((item: Product) => {
      return (
        item.goodsTitle.replaceAll(" ", "-").replace(/[#()&]/g, "") ===
        goodsTitle
      );
    });
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
    classifyList,
    getSearchProductList,
    getProductList,
    getProducParentTypetList,
    getSearchList,
    getProductInfo,
    classifyDiscountList,
    getIdProductInfo,
    getProductSortList,
    getProductTypeSortList,
    getProductCategory,
    getProducParentTypetListRandom,
    getProductBrandSortList,
    discountList,

    previewImgsList,
    curImgIndex,
    previewTitleList,
    previewImgsVisible,
    setPreviewImgInfo,
    closePreviewImg,
  };
});

