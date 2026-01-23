<script setup lang="ts">
import 'element-plus/theme-chalk/display.css'
const isShowMenu = ref(false);
const jumpPage = (path:string) => {
    isShowMenu.value = false;
    jumpPath(path);
}
onMounted(() => {
})
</script>
<template>
    <div>
        <div class="mainheader">
        <el-col :xs="23" :sm="23" :md="23" :lg="23" :xl="23">
            <div class="flex justify-between">
                <div class="main-logo">
                    <img width="40" height="40" src="@/assets/logo/icon.webp" alt="">
                    <div class="min-header-text">
                        <span class="text to-red-700">Vigorbuy Sheet</span>
                    </div>
                </div>

                <div class="main-pages hidden-xs-only">
                    <div class="item"
                    @click="jumpPage('/')"
                    :class="{ 'select-page': $route.name?.toString().endsWith('index') }">
                        <i class="icon iconfont icon-shouye"></i>
                        <span class="name">Vigorbuy Sheet</span>
                    </div>

                    <div class="item"
                    @click="jumpPage('/vigorbuybuy-spreadsheet')"
                    :class="{ 'select-page': $route.name === 'vigorbuybuy-spreadsheet' }">
                        <i class="icon iconfont icon-biaoge"></i>
                        <span class="name">Spreadsheet</span>
                    </div>

                    <div class="item">
                        <i class="icon iconfont icon-xiangji_o"></i>
                        <span class="name">QC Pictures</span>
                    </div>

                    <div class="item">
                        <i class="icon iconfont icon-shu"></i>
                        <span class="name">Guides</span>
                    </div>
                </div>

                <div class="coupons-btn">
                    Get Vigorbuy Coupons
                </div>

                <div class="main-menu" @click="isShowMenu = !isShowMenu">
                    <i class="icon iconfont" :class="{'icon-guanbi': isShowMenu, 'icon-a-11': !isShowMenu}"></i>
                </div>
            </div>
        </el-col>
        </div>
        <div class="main-menu-liet" v-if="isShowMenu">
            <el-col :xs="23" :sm="23" :md="23" :lg="23" :xl="23">
                <div class="menu-list">
                    <div class="item"
                    @click="jumpPage('/')"
                    :class="{ 'select-page': $route.name?.toString().endsWith('index') }">
                        <i class="icon iconfont icon-shouye"></i>
                        <span class="name">Vigorbuy Sheet</span>
                    </div>

                    <div class="item"
                    @click="jumpPage('/vigorbuybuy-spreadsheet')"
                    :class="{ 'select-page': $route.name === 'vigorbuybuy-spreadsheet' }">
                        <i class="icon iconfont icon-biaoge"></i>
                        <span class="name">Spreadsheet</span>
                    </div>

                    <div class="item">
                        <i class="icon iconfont icon-xiangji_o"></i>
                        <span class="name">QC Pictures</span>
                    </div>

                    <div class="item">
                        <i class="icon iconfont icon-shu"></i>
                        <span class="name">Guides</span>
                    </div>

                    <div class="buy-btn">
                        Get Oopbuy Coupons
                    </div>
                </div>
            </el-col>
        </div>
    </div>
</template>
<style lang="scss" scoped>
.select-page{
    color: #ff186b !important;
    background-color: #FEE7F0 !important;
}
.mainheader{
    height: 64px;
    // background-color: #fff;
    /* 核心毛玻璃属性 */
    background: rgba(255, 255, 255, 0.7); /* 白色半透明，可改 rgba(0,0,0,0.2) 深色玻璃 */
    backdrop-filter: blur(40px); /* 模糊半径，数值越大越模糊（推荐8-15px） */
    -webkit-backdrop-filter: blur(40px); /* 兼容 Safari */

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
            background: linear-gradient(to right, rgb(255, 24, 107) 0%, #C40003 100%); /* 浅粉 → 深粉，可替换颜色 */
      
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
            color: #666;
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
                background-color: rgba(226, 222, 222, 0.4);
                color: #333;
            }
        }
    }
    .coupons-btn{
        height: 40px;
        line-height: 40px;
        color: #fff;
        text-align: center;
        background-color: #ff186b;
        border-radius: 8px;
        padding: 0px 20px;
        cursor: pointer;
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
        display: none;
    }
    .main-menu-liet{
        box-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
        background-color: #fff;
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
                color: #666;
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
                    background-color: rgba(226, 222, 222, 0.4);
                    color: #333;
                }
            }
        }
        .buy-btn{
            background-color: #ff186b;
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
        // display: block !important;
        display: flex !important;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        cursor: pointer;
        border-radius: 8px;
        &:hover{
            background-color: var(--color-gray-100);
        }
    }
}

@media screen and (max-width: 500px) {
    .min-header-text{
        display: none;
    }
}
</style>