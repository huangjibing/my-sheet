<script setup lang="ts">
import type { TabItem } from "@/types/base";
interface Props {
  tabList: TabItem[];
  activeKey: string;
  customStyle?: Record<string, any>;
}
const props = defineProps<Props>();
defineEmits(["changeKey"]);

const tabBarRef = ref<HTMLElement | null>(null);

const activeIndex = computed(() => {
  return props.tabList?.findIndex((item) => item.key === props.activeKey);
});

watch(
  () => props.activeKey,
  () => {
    nextTick(() => {
      updateLineOffset();
    });
  }
);
onMounted(() => {
  updateLineOffset();
  window.addEventListener("resize", updateLineOffset);
});
onUnmounted(() => {
  window.removeEventListener("resize", updateLineOffset);
});

const lineOffset = ref({});

const updateLineOffset = () => {
  const tabBar = tabBarRef.value;
  if (!tabBar || activeIndex.value < 0) {
    lineOffset.value = {
      left: "0px",
      width: "0px",
    };
  } else {
    lineOffset.value = {
      left: `${
        (tabBar.children[activeIndex.value] as HTMLElement).offsetLeft + tabBar.children[activeIndex.value].clientWidth / 4
      }px`,
      width: `${tabBar.children[activeIndex.value].clientWidth / 2}px`,
    };
  }
};

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
</script>

<template>
  <div class="tab-bar-wrapper" :style="customStyle" ref="tabBarRef">
    <span
      class="tab-bar-item"
      :class="{ 'is-active': activeKey === item.key }"
      v-for="item in tabList"
      :key="item.key"
      @click="$emit('changeKey', item.key)"
    >
      <i class="icon-font" v-if="item.icon" :class="item.icon"></i>
      {{ isMobile == true ? item.label : item.key }}
    </span>
    <span class="tab-line" :style="lineOffset"></span>
  </div>
</template>

<style lang="scss" scoped>
.tab-bar-wrapper {
  display: flex;
  align-items: center;
  color: var(--text-01);
  font-size: 16px;
  font-weight: 700;
  line-height: 30px; /* 187.5% */
  // border-bottom: var(--bor);
  // width: 100%;
  border-bottom: 1px solid #E6E6F2;
  column-gap: 10px;
  position: relative;
  // max-width: max-content;
  // margin: auto;

  .tab-bar-item {
    padding: 13px 24px;
    cursor: pointer;
    &.is-active {
      // color: var(--primary);
      color: #A70012;
    }
    .icon-font {
      font-weight: 400;
      font-size: 24px;
    }
  }

  .tab-line {
    position: absolute;
    height: 2px;
    bottom: 0px;
    border-radius: 4px;
    // background-color: var(--primary);
    background-color: red;
    transition: all 0.2s ease-in-out;
  }
}

@media screen and (max-width: 768px) {
  .tab-bar-wrapper {
    font-size: 14px;
    overflow-x: auto;
    border-bottom: none;
    column-gap: 12px;
    border-bottom: 1px solid #E6E6F2;
    .tab-bar-item {
      padding: 13px 5px;
      white-space: nowrap;
    }
  }
  /*定义了滚动条整体样式；*/
  ::-webkit-scrollbar {
    height: 0px !important;
    width: 0px !important;
    display: none !important;
  }

  /*定义了滚动条滑块的样式*/
  ::-webkit-scrollbar-thumb {
    background: transparent;
  }

  /*定义了轨道的样式*/
  ::-webkit-scrollbar-track {
    /*滚动条里面轨道*/
    background: transparent;
  }
}
</style>
