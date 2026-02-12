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
        <div class="mainheader bg-[#121212]">
        <el-col :xs="23" :sm="23" :md="23" :lg="23" :xl="23">
            <div class="flex justify-between">
                <div class="main-logo" @click="jumpPath('/')">
                    <img width="30" height="30" src="@/assets/logo/icon.webp" alt="">
                    <div class="min-header-text">
                        <span class="text to-red-700">Vigorbuy Sheet</span>
                    </div>
                </div>

                <div class="main-pages hidden-xs-only">
                    <div class="item relative text-gray-400 hover:text-white"
                    @click="jumpPage('/')"
                    :class="{'text-white': $route.name?.toString().endsWith('index')}">
                        <span v-if="$route.name?.toString().endsWith('index')" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <!-- <i class="icon iconfont icon-shouye"></i> -->
                        <span class="name relative z-10">Home</span>
                    </div>

                    <div class="item relative text-gray-400 hover:text-white"
                    @click="jumpPage('/vigorbuy-spreadsheet')"
                    :class="{'text-white': $route.name === 'vigorbuy-spreadsheet'}"
                    >
                        <span v-if="$route.name === 'vigorbuy-spreadsheet'" class="absolute inset-0 bg-gradient-to-r from-[#DAA520]/20 to-[#FF0000]/20 rounded-full border border-[#ff0033]/40"></span>
                        <!-- <i class="icon iconfont icon-biaoge"></i> -->
                        <span class="name relative z-10">Spreadsheet</span>
                    </div>
                    
                    <div class="item relative text-gray-400 hover:text-white"
                    @click="jumpPage('/qc-pictures')"
                    :class="{'text-white': $route.name === 'qc-pictures'}"
                    >
                        <span v-if="$route.name === 'qc-pictures'" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <!-- <i class="icon iconfont icon-xiangji_o"></i> -->
                        <span class="name relative z-10">QC Pictures</span>
                    </div>

                    <div class="item relative text-gray-400 hover:text-white"
                    @click="jumpPage('/blog')"
                    :class="{'text-white': $route.name === 'blog'}"
                    >
                        <span v-if="$route.name === 'blog'" class="absolute inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40"></span>
                        <!-- <i class="icon iconfont icon-shu"></i> -->
                        <span class="name relative z-10">Guides</span>
                    </div>
                </div>

                <div class="coupons-btn text-white inset-0 theme-btn rounded-full" @click="openVigorbuy()">
                    <i class="icon iconfont icon-liwuhuodong animate-bounce w-3.5 h-3.5"></i>
                    <span>Get Vigorbuy Coupons</span>
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

                    <div class="buy-btn inset-0 theme-btn rounded-full">
                        Get Oopbuy Coupons
                    </div>
                </div>
            </el-col>
        </div>
    </div>
</template>
<style lang="scss" scoped>
.mainheader{
    height: 64px;
    // background-color: #fff;
    /* 核心毛玻璃属性 */
    // background: rgba(255, 255, 255, 0.7); /* 白色半透明，可改 rgba(0,0,0,0.2) 深色玻璃 */
    // backdrop-filter: blur(40px); /* 模糊半径，数值越大越模糊（推荐8-15px） */
    // -webkit-backdrop-filter: blur(40px); /* 兼容 Safari */

    box-shadow: 0 0px 2px rgba(0, 0, 0, 0.5); /* 阴影增强 */
    display: flex;
    justify-content: center;
    align-items: center;
    .main-logo{
        display: flex;
        height: 40px;
        align-items: center;
        cursor: pointer;
        .text{
            margin-left: 5px;
            font-size: 20px;
            font-weight: 900;
            // background: linear-gradient(to right, rgb(255, 24, 107) 0%, #C40003 100%); /* 浅粉 → 深粉，可替换颜色 */
            background: linear-gradient(to bottom right, #990000, #FF2D00, #FF7F00, #FFD700);
      
            /* 让渐变仅显示在文字区域 */
            -webkit-background-clip: text; /* 兼容 Safari/Chrome */
            background-clip: text;
            color: transparent; /* 隐藏原文字颜色，露出渐变 */
        }
        img{
            transition: transform 0.3s ease;
        }
        &:hover{
            img{
                transform: scale(1.2);
            }
        }
    }
    .main-pages{
        display: flex;
        gap: 10px;
        .item{
            display: flex;
            gap: 6px;
            height: 40px;
            align-items: center;
            padding: 0px 20px;
            border-radius: 8px;
            // color: #666;
            cursor: pointer;
            .icon{
                font-size: 16px;
                font-weight: 900;
            }
            .name{
                font-size: 14px;
                font-weight: 600;
                line-height: 40px;
            }
            &:hover{
                // background-color: rgba(226, 222, 222, 0.4);
                // color: #fff;
            }
        }
    }
    .coupons-btn{
        height: 40px;
        line-height: 40px;
        text-align: center;
        // background-color: #ff186b;
        border-radius: 8px;
        height: 40px;
        width: 207px;
        display: flex;
        justify-content: center;
        cursor: pointer;
        font-size: 14px;
        .icon{
            font-size: 11px;
            margin-right: 5px;
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