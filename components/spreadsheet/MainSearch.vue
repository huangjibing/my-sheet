<script setup lang="ts">
import { debounce } from 'lodash-es';
import { useBaseStore } from "@/store/base";
import type { TabItem } from "@/types/base";

interface Props {
  category: string,
  currency: string,
  search: string
}

const props = defineProps<Props>();
const classification = ref(props.category);
const emit = defineEmits(["changeCategory","currencyChange","changeSearch"]);

const currencyOptions = [
  {
    value: 'USD',
    label: 'USD',
  },
  {
    value: 'EUR',
    label: 'EUR',
  },
  {
    value: 'GBP',
    label: 'GBP',
  },
  {
    value: 'CAD',
    label: 'CAD',
  },
  {
    value: 'AUD',
    label: 'AUD',
  },
  {
    value: 'CNY',
    label: 'CNY',
  }
]

const currency = ref(props.currency);
const baseStore = useBaseStore();
const classificationList = computed<TabItem[]>(() => {
  const arr: TabItem[] = [];
  baseStore.classifyDiscountList.forEach((item) => {
    arr.push({
      key: item,
      label: item,
    });
  });
  return arr;
});
const search = ref(props.search);
const categoryChange = (value:any) => {
  emit('changeCategory', value)
}
const currencyChange = (value:any) => {
  emit('currencyChange', value)
}
const searchChangeEmit = () => {
  emit('changeSearch', search.value);
}
const searchChange = debounce(searchChangeEmit, 500);
</script>
<template>
    <el-row :gutter="12" class="search-input">
      <el-col :xs="24" :sm="10" :md="12" :lg="14" :xl="16" class="search-col">
        <div style="height: 60px;" class="input-height">
          <el-input
          style="height: 100%;"
          v-model="search"
          @input="searchChange"
          placeholder="Search products..">
            <template #prefix>
              <i class="icon iconfont icon-sousuo"></i>
            </template>
          </el-input>
        </div>
      </el-col>
      <el-col :xs="24" :sm="8" :md="7" :lg="6" :xl="5" class="search-col">
        <div style="height: 60px;" class="input-height">
          <el-select v-model="classification" placeholder="Select" @change="categoryChange">
            <template #prefix>
            <i class="icon iconfont icon-fenlei"></i>
            </template>
            <el-option
              v-for="item in classificationList"
              :key="item.key"
              :label="item.label"
              :value="item.key"
            />
          </el-select>
        </div>
      </el-col>

      <el-col :xs="24" :sm="6" :md="5" :lg="4" :xl="3" class="search-col">
        <div style="height: 60px;" class="input-height">
          <el-select v-model="currency" placeholder="Select" @change="currencyChange">
            <el-option
              v-for="item in currencyOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </div>
      </el-col>
    </el-row>
</template>
<style lang="scss" scoped>
.search-input{
  border: 1px solid #CD2A0D;
  box-shadow: rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.25) 0px 25px 50px -12px;
  padding: 24px;
  border-radius: 24px;
  background-color: #fff;
}
.input-height{
  height: 60px;
}
:deep(.el-input__wrapper){
  border-radius: 12px;
}
:deep(.el-select__wrapper){
  height: 60px;
  border-radius: 12px;
}
@media (max-width: 767px) {
  .search-col:not(:first-child) {
    margin-top: 12px; /* 最小屏垂直间隔，可按需调整 */
  }
  .input-height{
    height: 45px !important;
  }
  :deep(.el-select__wrapper){
    height: 45px;
    border-radius: 12px;
  }
}
</style>