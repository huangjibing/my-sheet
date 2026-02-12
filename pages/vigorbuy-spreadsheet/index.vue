<script setup lang="ts">
import type { MainScrollEventOptions } from '@/types/eventBus';
import { debounce } from 'lodash-es';
import JoinDiscordDialog from '@/components/dialog/JoinDiscordDialog.vue';
const handleScroll = (options: MainScrollEventOptions) => {
    if (options.type != 'homeScroll') {
        return;
    }
    sessionStorage.setItem('vigorbuy-spreadsheet', options.data.scrollTop.toString());
}
const debouncedScroll = debounce(handleScroll, 100);
onMounted(() => {
  mainScrollEvent.on(debouncedScroll);
  nextTick(() => {
    const pos = sessionStorage.getItem('vigorbuy-spreadsheet');
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

const showDiscord = ref(false);
const closeDiscord = () => {
    showDiscord.value = false;
}
const showDiscordSet = () => {
    showDiscord.value = true;
}
onUnmounted(() => {
  mainScrollEvent.off(debouncedScroll);
});
</script>
<template>
    <JoinDiscordDialog v-if="showDiscord" @onClose="closeDiscord" />
    <div class="spreadsheet-wrapper relative">
        <div class="absolute animate-pulse left-1/4 w-[600px] h-[300px] bg-[radial-gradient(circle,rgba(255,45,0,0.45)_0%,rgba(255,127,0,0.08)_40%,transparent_70%)] blur-2xl"></div>
        <div class="header max-w-7xl mx-auto px-4 sm:!px-6 lg:!px-8 py-8">
            <div class="mb-4 font-14">
                <span class="home text-gray-500" @click="jumpPath('/')">
                    <i class="icon iconfont icon-shouye"></i>
                    <span class="ml-3">Home</span>
                </span>
                <i class="icon iconfont icon-xiangyoujiantou ml-5 font-12 text-gray-500"></i>
                <span class="ml-5 text-white">Vigorbuy Spreadsheet</span>
            </div>

            <div class="theme-text text-3xl sm:text-4xl font-bold mb-3 heme-btn">
                <h1>Vigorbuy Spreadsheet</h1>
            </div>

            <p class="text-lg text-slate-400 max-w-3xl">
                Browse 8,407+ verified products from Taobao, 1688, and Weidian. Links verified weekly, updated daily.
            </p>
            
            <div class="header-flooter mt-6">
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

        <SpreadsheetMainProductList @shwoDiscord="showDiscordSet" />
    </div>
</template>
<style lang="scss" scoped>
.spreadsheet-wrapper{
    overflow-x: hidden;
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
            color: #687282;
            flex-wrap: wrap;
            .icon{
                font-size: 12px;
            }
        }
    }
}
</style>