<script setup lang="ts">
import { useBaseStore } from "@/store/base";
const baseStore = useBaseStore();
const route = useRoute();
const category = ref(route.query.category?.toString() || 'All Categories');
const currency = ref(route.query.currency?.toString() || 'USD');
const search = ref(route.query.search?.toString() || '');
const page = ref(Math.max(Number(route.query.page) || 1, 1));
const pageSize = ref(20);
const productList = computed(() => {
    return baseStore.getSearchProductList(search.value, category.value != 'All Categories' ? category.value : '');
});
const productCurList = computed(() => {
    let list = productList.value.slice((page.value - 1) * pageSize.value, page.value * pageSize.value);
    return list;
});

const changeCategory = (value:string) => {
    page.value = 1;
    category.value = value;
    addUrlParam();
}
const changePage = (value:number) => {
    page.value += value;
    addUrlParam();
}
const currencyChange = (value:string) => {
    page.value = 1;
    addUrlParam();
}
const changeSearch = (value:string) => {
    search.value = value;
    page.value = 1;
    addUrlParam();
}
const router = useRouter();
const addUrlParam = () => {
  const newQuery = {
    ...(search.value ? { search: search.value } : {}),
    ...(category.value && category.value !== 'All Categories' ? { category: category.value } : {}),
    ...(currency.value && currency.value !== 'USD' ? { currency: currency.value } : {}),
    ...(page.value && page.value !== 1 ? { page: page.value } : {})
  };
  router.replace({
    path: route.path,
    query: newQuery
  });

   mainScrollEvent.emit({
        type: 'toScroll',
        data: {
            scrollTop: 0,
            clientHeight: 0,
            scrollHeight: 0,
        },
    });
};
</script>
<template>
    <div class="mainproduct-wrapper bg-gray-50">
        <div class="content-data">
            <SpreadsheetMainSearch
            @changeCategory="changeCategory"
            @currencyChange="currencyChange"
            @changeSearch="changeSearch"
            :search="search" :category="category" :currency="currency" class="search" />
            <div class="products-list" v-if="productCurList.length">
                <ProductItem
                    v-for="item in productCurList"
                    :productInfo="item"
                    :key="item.id"
                />
            </div>

            <SpreadsheetMainPagination @changePage="changePage" :page="page" :size="pageSize" :total="productList.length" class="mt-20" />
        </div>
    </div>
</template>
<style lang="scss" scoped>
.mainproduct-wrapper{
     .content-data{
        padding: 32px;
        max-width: 1800px;
        margin-left: auto;
        margin-right: auto;
        .search{
            margin-bottom: 30px;
        }
        .products-list {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
        }
    }
}
@media (max-width: 1200px) {
    .products-list{
        grid-template-columns: repeat(4, 1fr) !important;
        gap: 10px !important;
    }
}
@media (max-width: 992px) {
    .products-list{
        grid-template-columns: repeat(3, 1fr) !important;
        gap: 10px !important;
    }
}
@media (max-width: 767px) {
    .mainproduct-wrapper{
        .content-data{
            padding: 10px;
            .products-list{
                grid-template-columns: repeat(2, 1fr) !important;
                gap: 10px !important;
            }
        }
    }
}
</style>