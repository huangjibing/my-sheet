<script setup lang="ts">
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
  <div class="beginner-video-wrapper" :class="{
    'aspect-ratio-9-16' : isMobile,
    'aspect-ratio-16-9': !isMobile
  }">
    <video
      class="beginner-video"
      :poster="isMobile === false ? 'https://cdn.static.vigorbuy.com/assets/beginner/sheetWebCover.jpeg' : 'https://cdn.static.vigorbuy.com/assets/beginner/sheetH5Cover.jpeg'"
      controls
    >
      <source :src="isMobile === false ? 'https://cdn.static.vigorbuy.com/assets/beginner/sheetWebTeach.mp4' : 'https://cdn.static.vigorbuy.com/assets/beginner/sheetH5Teach.mp4'" type="video/mp4" />
      Your browser does not support the video tag.
    </video>
  </div>
</template>

<style lang="scss" scoped>
.beginner-video-wrapper {
  width: min(100%, 800px);
  border-radius: 8px;
  overflow: hidden;
  background-color: #fff;
}
.aspect-ratio-16-9{
  aspect-ratio: 16 / 9;
}
.aspect-ratio-9-16{
  aspect-ratio: 12 / 16;
}
.beginner-video {
  width: 100%;
  height: 100%;
  border-radius: 8px;
  cursor: pointer;
}
@media screen and (max-width: 768px) {
  .beginner-video-wrapper{
    height: 400px;
    background-color: none;
  }
}
</style>
