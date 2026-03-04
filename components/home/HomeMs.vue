<script setup lang="ts">
const route = useRoute();
const inviteCode = ref("");
const openVigorbuy = () => {
  if (inviteCode.value) {
    openLink(`https://vigorbuy.com/?inviteCode=${inviteCode.value}&utm_source=vigorbuysheet`)
  } else {
    openLink(`https://vigorbuy.com/?utm_source=vigorbuysheet`)
  }
}
onMounted(() => {
  inviteCode.value =
    route.query.inviteCode?.toString() ||
    localStorage.getItem("inviteCode") ||
    "bkwNqLO7";
});
</script>
<template>
    <div class="homems-wrapper overflow-hidden flex justify-center relative px-4 sm:!px-6 lg:!px-8 py-16 sm:!py-20 lg:!py-28">
        <div class="absolute w-[600px] h-[300px] bg-[radial-gradient(circle,rgba(255,45,0,0.15)_0%,rgba(255,127,0,0.08)_40%,transparent_70%)] blur-2xl"></div>
        <div class="homems-content z-[1] text-center flex overflow-hidden max-w-7xl">
            <span class="theme-text font-[900] text-4xl sm:!text-5xl md:!text-6xl lg:!text-7xl mb-4">Vigorbuy Sheet</span>
            <span class="text-gray-300 font-[800] text-2xl sm:!text-3xl md:!text-4xl mb-2">The Complete Vigorbuy Spreadsheet</span>

            <div class="text-center max-w-3xl mx-auto">
                <p class="mt-30 text-gray-400 text-lg sm:!text-xl">Find verified products from Taobao, 1688, and Weidian in one searchable database. Built for buyers who want to skip the guesswork and shop with confidence.</p>
                <p class="mt-10 text-gray-500">Over 10,000 products with QC photos, working links, and real pricing. Updated daily. Free to use.</p>
            </div>

            <div class="homems-btn flex gap-[20px] h-[68px] items-center mt-[30px] justify-center">
                <div class="the-admin theme-btn h-[68px] flex items-center text-white justify-center pointer rounded-[40px]" @click="jumpPath('/vigorbuy-spreadsheet')">
                    <span>Browse the Vigorbuy Spreadsheet</span>
                    <i class="icon iconfont icon-youjiantou ml-8"></i>
                </div>

                <div class="the-lw pointer text-white theme-btn h-[60px] flex items-center justify-center rounded-[40px]" @click="openVigorbuy()">
                    <i class="icon iconfont icon-liwuhuodong animate-bounce w-3.5 h-5.5"></i>
                    <span class="ml-2">Get Vigorbuy Coupons</span>
                </div>
            </div>

            <div class="homems-assure flex gap-[20px] justify-center mt-[40px] flex-wrap">
                <div class="h-[32px] flex items-center gap-[5px] rounded-[20px] pl-[15px] pr-[15px] bg-[#F0FDF4]">
                    <i class="icon iconfont icon-xuanzhong text-[#00C753]"></i>
                    <span class="text-[#475565] text-[14px] font-[600]">110,000+ Products</span>
                </div>

                <div class="h-[32px] flex items-center gap-[5px] rounded-[20px] pl-[15px] pr-[15px] bg-[#EEF6FF]">
                    <i class="icon iconfont icon-xuanzhong text-[#0083FF]"></i>
                    <span class="text-[#475565] text-[14px] font-[600]">QC Photos</span>
                </div>

                <div class="h-[32px] flex items-center gap-[5px] rounded-[20px] pl-[15px] pr-[15px] bg-[#F9F5FF]">
                    <i class="icon iconfont icon-xuanzhong text-[#9B4FFF]"></i>
                    <span class="text-[#475565] text-[14px] font-[600]">Updated Daily</span>
                </div>

                <div class="h-[32px] flex items-center gap-[5px] rounded-[20px] pl-[15px] pr-[15px] bg-[#FFF7ED]">
                    <i class="icon iconfont icon-xuanzhong text-[#FF6800]"></i>
                    <span class="text-[#475565] text-[14px] font-[600]">Free to Use</span>
                </div>
            </div>
        </div>
    </div>
</template>
<style lang="scss" scoped>
    .homems-wrapper{
        .homems-content{
            flex-direction: column;
            .homems-btn{
                .the-admin{
                    width: 391px;
                    .icon{
                        transition: transform 0.3s ease;
                    }
                    &:hover{
                        .icon{
                            transform: translateX(8px)
                        }
                    }
                }
                .the-lw{
                    width: 261px;
                }
            }
        }
    }

    @media (max-width: 768px) {
        .homems-wrapper{
            .homems-content{
                .homems-btn{
                    flex-direction: column;
                    height: auto;
                    .the-admin{
                        width: 100%;
                    }
                }
            }
        }
    }
</style>