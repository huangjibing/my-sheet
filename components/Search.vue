<script setup lang="ts">
import { Search, ArrowLeft } from '@element-plus/icons-vue';
interface Props {
  searchTxt?: string;
  scroll?: boolean;
}
const props = defineProps<Props>();
const searchKey = ref(props.searchTxt || "");

const hotKey = [
  // "Adidas",
  // "Air Jordan",
  // "Ami",
  // "Burberry",
  // "Balenciaga",
  "Suit",
  "Shoes",
  // "Women clothes",
  "Hoodie",
  "Sweatshirt",
  "Sweater",
  "T-shirt",
  "Polo shirt",
  "Shorts",
  "Jacket",
  "Down Jacket",
  // "Pants"
];

const emit = defineEmits(["onSearch"]);
const handleSearch = (txt?: string) => {
  if (!txt && !searchKey.value.trim()) return;
  searchKey.value = txt || searchKey.value;
  emit("onSearch", txt || searchKey.value);
};

const clearSearchKey = () => {
  searchKey.value = '';
}

const router = useRouter();
const route = useRoute();

const toDiscount = () => {
  searchKey.value = '';
  router.push({
    path: `/discount`
  });
}
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

defineExpose({
  clearSearchKey
})

const routeName = computed(() => {
  return route.name;
})

const toPage = () => {
  router.go(-1);
}

</script>

<template>
  <div class="search-container">
    <el-icon v-show="isMobile && routeName != 'index'" class="mr-5" @click="toPage()"><ArrowLeft /></el-icon>
    <div class="search-wrapper">
      <el-icon class="search-input-icon"><Search /></el-icon>
      <input
        type="text"
        class="search-input"
        placeholder="Enter Product Name"
        v-model="searchKey"
        @keyup.enter="handleSearch()"
      />
      <div
        class="search-btn"
        :class="{ disabled: !searchKey.trim() }"
        @click="handleSearch()"
      >
        Search
    </div>
    </div>
    <div class="search-hot-key" v-show="false">
      <!-- <div class="flex gap-12">
        <span v-if="!isMobile" class="tag-item" @click="toDiscount">
          <img class="img" src="@/assets/logo/discount.png" alt="">
          <div class="title">Up to 15% off</div>
        </span>
        <span class="tag-item" v-for="item in hotKey" @click="handleSearch(item)">
          {{ item }}
        </span>
      </div>

      <Countdown v-if="!isMobile"/> -->
    </div>
  </div>
</template>

<style lang="scss" scoped>
.search-container {
  // max-width: 1643px;
  min-width: 400px;
  display: flex;
}

.search-wrapper {
  height: 60px;
  display: flex;
  align-items: center;
  background-color: #ffffff;
  border-radius: 80px;
  // border: 1px solid var(--primary);
  border: 3px solid #FF0039;
  width: 1262.2px;
}
.search-input {
  flex: 1;
  border: 0;
  outline: none;
  padding: 12px 8px;
  border-radius: 80px;
  font-size: 20px;
  width: 100%;
}
.search-input::placeholder{
  color: #ADB8CC !important;
} 
.search-input-icon{
  font-size: 24px;
  color: #ADB8CC;
  margin-left: 10px;
}
.search-btn {
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border: 0;
  // background-color: #060606;
  background: #FF0039;
  border-radius: 80px;
  // color: #CEFE25;
  color: #fff;
  font-feature-settings: 'liga' off, 'clig' off;
  font-size: 18px;
  font-style: normal;
  font-weight: 600;
  line-height: 30px; /* 166.667% */

  padding: 0 24px;
  margin-right: 2px;
  &.disabled {
    cursor: not-allowed;
    // opacity: 0.8;
  }
}

.search-hot-key {
  margin-top: 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  overflow-x: auto;
}

.tag-item {
  padding: 0px 16px;
  border-radius: 30px;
  white-space: nowrap;
  background-color: #F5F8FD;
  color: #000;
  font-feature-settings: 'liga' off, 'clig' off;
  font-size: 14px;
  font-style: normal;
  font-weight: 400;
  cursor: pointer;
  display: flex;
  line-height: 35px;
  &:hover {
  }
  .img{
    width: 35px;
    height: 35px;
  }
  .title{
    color: #E82036;
    font-feature-settings: 'liga' off, 'clig' off;
    font-size: 16px;
    font-style: normal;
    font-weight: 700;
  }
}

@media screen and (max-width: 768px) {
  .search-container {
    max-width: 95vw;
    min-width: 95vw;
    margin-left: 2.5vw;
    height: 35px;
    align-items: center;
  }
  .search-wrapper {
    height: 35px;
    width: 100%;
    border: 2px solid #FF0039;
  }
  .search-input {
    font-size: 16px;
    margin: 0px;
    padding: 0px 6px;
  }
  .search-input-icon{
    font-size: 20px;
  }
  .search-btn {
    height: 29.5px;
    font-size: 14px;
    margin-right: 1.5px;
    padding: 0 12px;
  }
  .search-hot-key {
    overflow-x: auto;
    margin-top: 10px;
    // display: none;
  }
  .tag-item {
    font-size: 14px;
    // background-color: rgba($color: #000000, $alpha: 0);
    background-color: #fff;
    border-radius: 20px;
    // color: #fff;
    padding: 0px 10px;
    line-height: 25px;
  }
  .search-hot-key::-webkit-scrollbar {
    display: none;
  }
}
</style>
