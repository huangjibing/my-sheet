<script setup lang="ts">
import 'element-plus/theme-chalk/display.css'
const isShowMenu = ref(false);
const route = useRoute();
const jumpPage = (path:string) => {
    isShowMenu.value = false;
    jumpPath(path);
}
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
    <div>
        <div class="mainheader h-[64px] bg-[#121212] flex justify-center items-center">
        <el-col :xs="23" :sm="23" :md="23" :lg="23" :xl="23">
            <div class="flex justify-between">
                <div class="main-logo flex h-[40px] items-center pointer" @click="jumpPath('/')">
                    <img width="30" height="30" src="@/assets/logo/logo.png" alt="">
                    <div class="min-header-text">
                        <span class="ml-[5px] text-[20px] font-[900] theme-text">VIGORBUY</span>
                    </div>
                </div>

                <div class="flex gap-[10px] hidden-xs-only">
                    <div class="flex gap-[6px] h-[40px] items-center pl-[20px] pr-[20px] rounded-[8px] pointer relative text-gray-400 hover:text-white"
                    @click="jumpPage('/')"
                    :class="{'text-white': $route.name?.toString().endsWith('index')}">
                        <span v-if="$route.name?.toString().endsWith('index')" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <span class="text-[14px] font-[600] leading-[40px] relative z-10">Home</span>
                    </div>

                    <div class="flex gap-[6px] h-[40px] items-center pl-[20px] pr-[20px] rounded-[8px] pointer relative text-gray-400 hover:text-white"
                    @click="jumpPage('/vigorbuy-spreadsheet')"
                    :class="{'text-white': $route.name === 'vigorbuy-spreadsheet'}"
                    >
                        <span v-if="$route.name === 'vigorbuy-spreadsheet'" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <span class="text-[14px] font-[600] leading-[40px] relative z-10">Spreadsheet</span>
                    </div>
                    
                    <div class="flex gap-[6px] h-[40px] items-center pl-[20px] pr-[20px] rounded-[8px] pointer relative text-gray-400 hover:text-white"
                    @click="jumpPage('/qc-pictures')"
                    :class="{'text-white': $route.name === 'qc-pictures'}"
                    >
                        <span v-if="$route.name === 'qc-pictures'" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <span class="text-[14px] font-[600] leading-[40px] relative z-10">QC Pictures</span>
                    </div>

                    <div class="flex gap-[6px] h-[40px] items-center pl-[20px] pr-[20px] rounded-[8px] pointer relative text-gray-400 hover:text-white"
                    @click="jumpPage('/blog')"
                    :class="{'text-white': $route.name === 'blog'}"
                    >
                        <span v-if="$route.name === 'blog'" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <span class="text-[14px] font-[600] leading-[40px] relative z-10">Guides</span>
                    </div>
                </div>

                <div class="coupons-btn text-white theme-btn h-[40px] leading-[40px] rounded-[8px] flex gap-[5px] justify-center text-[17px] pointer" @click="openLink('https://discord.com/invite/nmRxUPDK9m')">
                    <!-- <i class="icon iconfont icon-liwuhuodong animate-bounce w-3.5 h-3.5 !text-[12px]"></i> -->
                    <span>Join the Discord</span>
                </div>

                <div class="main-menu text-white" @click="isShowMenu = !isShowMenu">
                    <i class="icon iconfont icon-guanbi" v-if="isShowMenu"></i>
                    <i class="icon iconfont icon-a-11" v-if="!isShowMenu"></i>
                </div>
            </div>
        </el-col>
        </div>
        <div class="main-menu-liet bg-[#1E1E1E]" v-if="isShowMenu">
            <el-col :xs="23" :sm="23" :md="23" :lg="23" :xl="23">
                <div class="menu-list">
                    <div class="item text-gray-300"
                    @click="jumpPage('/')"
                    :class="{ 'inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40': $route.name?.toString().endsWith('index') }">
                        <i class="icon iconfont icon-shouye"></i>
                        <span class="name">Home</span>
                    </div>

                    <div class="item text-gray-300"
                    @click="jumpPage('/vigorbuy-spreadsheet')"
                    :class="{ 'inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40': $route.name === 'vigorbuy-spreadsheet' }">
                        <i class="icon iconfont icon-biaoge"></i>
                        <span class="name">Spreadsheet</span>
                    </div>

                    <div class="item text-gray-300"
                    @click="jumpPage('/qc-pictures')"
                    :class="{ 'inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40': $route.name === 'qc-pictures' }">
                        <i class="icon iconfont icon-xiangji_o"></i>
                        <span class="name">QC Pictures</span>
                    </div>

                    <div class="item text-gray-300"
                    @click="jumpPage('/blog')"
                    :class="{ 'inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40': $route.name === 'blog' }">
                        <i class="icon iconfont icon-shu"></i>
                        <span class="name">Guides</span>
                    </div>

                    <div class="buy-btn inset-0 theme-btn rounded-full" @click="openLink('https://discord.com/invite/nmRxUPDK9m')">
                        Join the Discord
                    </div>
                </div>
            </el-col>
        </div>
    </div>
</template>
<style lang="scss" scoped>
.mainheader{
    .main-logo{
        img{
            transition: transform 0.3s ease;
        }
        &:hover{
            img{
                transform: scale(1.2);
            }
        }
    }
    .coupons-btn{
        width: 182px;
        .icon{
        }
    }
    .main-menu{
        display: none;
        width: 40px;
        height: 40px;
    }
}
.main-menu-liet{
    display: none;
}
@media screen and (max-width: 768px) {
    .coupons-btn{
        display: none !important;
    }
    .main-menu-liet{
        box-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
        // background-color: #fff;
        padding-top: 10px;
        padding-bottom: 10px;
        display: flex;
        justify-content: center;
        .menu-list{
            display: flex;
            flex-direction: column;
            gap: 8px;
            .item{
                height: 48px;
                cursor: pointer;
                border-radius: 8px;
                padding: 0px 10px;
                display: flex;
                align-items: center;
                gap: 6px;
                 .icon{
                    font-size: 16px;
                    font-weight: 900;
                }
                .name{
                    font-size: 14px;
                    font-weight: 600;
                    line-height: 40px;
                }
            }
        }
        .buy-btn{
            border-radius: 8px;
            height: 48px;
            text-align: center;
            line-height: 48px;
            color: #fff;
            font-size: 20px;
            font-weight: 600;
        }
    }
    .main-menu{
        display: flex !important;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        cursor: pointer;
    }
}

@media screen and (max-width: 500px) {
    .min-header-text{
        display: none;
    }
}
</style>