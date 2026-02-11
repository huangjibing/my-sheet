<script setup lang="ts">
import type { GirdsItem } from "~/types/base";
interface Props {
  grids: GirdsItem;
}
const props = defineProps<Props>();

</script>
<template>
    <div class="grids-item border border-white/10 bg-white/5" @click="jumpPath(grids.page)">
        <div class="grids-img-wrapper">
            <el-image fit="cover" class="grids-img" loading="lazy" :src="grids.image" />
        </div>
        <div class="p-6">
            <div class="flex items-center gap-3 text-xs text-slate-500 mb-3">
                <span class="px-2 py-1 bg-purple-500/10 text-purple-400 rounded-full font-medium">{{ grids.tag }}</span>
                <div class="flex items-center gap-1">
                    <i class="icon iconfont icon-shijian"></i>
                    {{ grids.time }} min read
                </div>
            </div>

            <h3 class="title text-lg font-bold mb-2 line-clamp-2 transition-colors text-white">
               {{ grids.title }}
            </h3>

            <p class="text-sm text-slate-400 line-clamp-2 mb-4">
                {{ grids.content }}
            </p>

            <div class="more text-[#FF186B] bold-700">
                <span>Read More</span>
                <i class="ml-5 font-13 icon iconfont icon-youjiantou"></i>
            </div>
        </div>
    </div>
</template>
<style lang="scss" scoped>
.grids-item{
    cursor: pointer;
    border-radius: 12px;
    overflow: hidden;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    &:hover{
        transform: translateY(-8px);
        .grids-img{
          transform: scale(1.1); /* 轻微放大 */
        }
        .title{
            color: #FF186B;
        }
        .more{
            .icon{
                transform: translateX(4px);
            }
        }
    }
    .more{
        display: flex;
        align-items: center;
        gap: 2px;
        .icon{
            transition: transform 0.3s ease;
            margin-top: 5px;
        }
    }
    .grids-img-wrapper {
        width: 100%;
        padding-bottom: 236px;
        position: relative;
        margin: auto;
        overflow: hidden;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }
    .grids-img {
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
}
</style>