<script setup lang="ts">
import type { MainScrollEventOptions } from '@/types/eventBus';
import { debounce } from 'lodash-es';
const handleScroll = (options: MainScrollEventOptions) => {
    if (options.type != 'homeScroll') {
        return;
    }
    sessionStorage.setItem('vigorbuybuy-spreadsheet', options.data.scrollTop.toString());
}
const debouncedScroll = debounce(handleScroll, 100);
onMounted(() => {
  mainScrollEvent.on(debouncedScroll);
  nextTick(() => {
    const pos = sessionStorage.getItem('vigorbuybuy-spreadsheet');
    if (pos) {
        mainScrollEvent.emit({
            type: 'toScroll',
            data: {
                scrollTop: Number(pos),
                clientHeight: 0,
                scrollHeight: 0,
            },
        });
    }
  })
});

onUnmounted(() => {
  mainScrollEvent.off(debouncedScroll);
});
</script>
<template>
    <div class="spreadsheet-wrapper">
        <div class="header max-w-7xl mx-auto px-4 sm:!px-6 lg:!px-8 py-8">
            <div class="mb-7 font-14">
                <span class="home text-gray-500" @click="jumpPath('/')">
                    <i class="icon iconfont icon-shouye"></i>
                    <span class="ml-3">Home</span>
                </span>
                <i class="icon iconfont icon-xiangyoujiantou ml-5 font-12"></i>
                <span class="ml-5">Vigorbuy Spreadsheet</span>
            </div>

            <div class="mb-10">
                <h1>Vigorbuy Spreadsheet</h1>
            </div>

            <p class="text-gray-600 mb-15">
                Browse 8,407+ verified products from Taobao, 1688, and Weidian. Links verified weekly, updated daily.
            </p>
            
            <div class="header-flooter">
                <div>
                    <i class="icon iconfont icon-weisa text-green-500"></i>
                    <span class="ml-8">Weekly link verification</span>
                </div>

                <div>
                    <i class="icon iconfont icon-weisa text-green-500"></i>
                    <span class="ml-8">Seller history checked</span>
                </div>

                <div>
                    <i class="icon iconfont icon-weisa text-green-500"></i>
                    <span class="ml-8">Dead links removed daily</span>
                </div>
            </div>
        </div>

        <SpreadsheetMainProductList />
    </div>
</template>
<style lang="scss" scoped>
.spreadsheet-wrapper{
    .header{
        .home{
            cursor: pointer;
            &:hover{
                color: #FF186B;
            }
        }
        .header-flooter{
            display: flex;
            gap: 10px;
            font-size: 14px;
            color: lab(47.7841 -0.393182 -10.0268);
            flex-wrap: wrap;
            .icon{
                font-size: 12px;
            }
        }
    }
}
</style>