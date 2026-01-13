<script setup lang="ts">
import type { MainScrollEventOptions } from '@/types/eventBus';
const scrollWrapper = ref();
const handleScroll = () => {
    if (!scrollWrapper.value?.wrapRef) return;
    const { scrollTop, clientHeight, scrollHeight } = scrollWrapper.value.wrapRef;
    mainScrollEvent.emit({
        type: 'homeScroll',
        data: {
            scrollTop,
            clientHeight,
            scrollHeight,
        },
    });
}

const toScroll = (options: MainScrollEventOptions) => {
    if (options.type === 'toScroll') {
        scrollWrapper.value.scrollTo({
            top: options.data.scrollTop
        })
    }
}

onMounted(() => {
    mainScrollEvent.on(toScroll);
})
</script>
<template>
<el-scrollbar class="home-scroll" ref="scrollWrapper" @scroll="handleScroll">
    <div class="home-container">
        <MainHeader class="header-layout" />
        <div class="content-wrapper">
            <slot></slot>
        </div>
    </div>
</el-scrollbar>
</template>
<style lang="scss" scoped>
    .home-scroll{
        height: 100vh;
    }
    .home-container {
        .header-layout {
            position: fixed;
            width: 100%;
            top: 0px;
            z-index: 5;
        }
        .content-wrapper{
            margin-top: 60px;
        }
    }
</style>