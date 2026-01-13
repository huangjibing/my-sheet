<script setup lang="ts">
import { useBaseStore } from '~/store/base';

const baseStore = useBaseStore();

const handleSwitch = (index: number) => {
  baseStore.curImgIndex = index;
};
</script>

<template>
  <div class="preview-wrapper">
    <el-image-viewer
      :url-list="baseStore.previewImgsList"
      :initial-index="baseStore.curImgIndex"
      @switch="handleSwitch"
      :hide-on-click-modal="true"
      @close="baseStore.closePreviewImg()"
    />
    <span class="preview-index" v-if="baseStore.previewImgsList.length > 1">
      <b class="cur-index">{{ baseStore.curImgIndex + 1 }}</b> / {{ baseStore.previewImgsList.length }}
    </span>
    <span v-if="baseStore.previewTitleList.length" class="preview-title">
      {{ baseStore.previewTitleList[baseStore.curImgIndex] }}
    </span>
  </div>
</template>

<style lang="scss" scoped>
.preview-index {
  position: fixed;
  top: 16px;
  left: 0;
  right: 0;
  width: max-content;
  margin: auto;
  z-index: 9999;
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  background-color: rgba(0, 0, 0, 0.5);
  padding: 4px 12px;
  border-radius: 30px;
  .cur-index {
    font-size: 18px;
  }
}

.preview-title {
  position: fixed;
  bottom: 80px;
  left: 0;
  right: 0;
  width: max-content;
  margin: auto;
  z-index: 9999;
  padding: 0 8px;
  font-size: 12px;
  line-height: 24px;
  color: #fff;
  border-radius: 4px;
  border: 1px solid #fff;
  background-color: rgba(0, 0, 0, 0.3);
}
</style>
