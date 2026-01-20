<script setup lang="ts">

</script>
<template>
    <div class="homems-wrapper px-4 sm:!px-6 lg:!px-8 py-16 sm:!py-20 lg:!py-28">
        <div class="homems-content max-w-7xl">
            <span class="title text-4xl sm:!text-5xl md:!text-6xl lg:!text-7xl">Vigorbuy Sheet</span>
            <span class="subtitle text-2xl sm:!text-3xl md:!text-4xl">The Complete Vigorbuy Spreadsheet</span>

            <div class="describe max-w-3xl mx-auto">
                <p class="mt-30 text-gray-700 text-lg sm:!text-xl">Find verified products from Taobao, 1688, and Weidian in one searchable database. Built for buyers who want to skip the guesswork and shop with confidence.</p>
                <p class="mt-10 text-gray-700">Over 10,000 products with QC photos, working links, and real pricing. Updated daily. Free to use.</p>
            </div>

            <div class="homems-btn">
                <div class="the-admin" @click="jumpPath('/vigorbuybuy-spreadsheet')">
                    <span>Browse the Vigorbuy Spreadsheet</span>
                    <i class="icon iconfont icon-youjiantou ml-8"></i>
                </div>

                <div class="the-lw">
                    <i class="icon iconfont icon-liwuhuodong"></i>
                    <span class="ml-5">Get Vigorbuy Coupons</span>
                </div>
            </div>

            <div class="homems-assure">
                <div class="item bg-products">
                    <i class="icon iconfont icon-xuanzhong icon-color-products"></i>
                    <span class="name">100,000+ Products</span>
                </div>

                <div class="item bg-photos">
                    <i class="icon iconfont icon-xuanzhong icon-color-photos"></i>
                    <span class="name">QC Photos</span>
                </div>

                <div class="item bg-daily">
                    <i class="icon iconfont icon-xuanzhong icon-color-daily"></i>
                    <span class="name">Updated Daily</span>
                </div>

                <div class="item bg-use">
                    <i class="icon iconfont icon-xuanzhong icon-color-use"></i>
                    <span class="name">Free to Use</span>
                </div>
            </div>
        </div>
    </div>
</template>
<style lang="scss" scoped>
    .bg-products{
        background-color: #F0FDF4;
    }
    .icon-color-products{
        color: #00C753;
    }
    .bg-photos{
        background-color: #EEF6FF;
    }
    .icon-color-photos{
        color: #0083FF;
    }
    .bg-daily{
        background-color: #F9F5FF;
    }
    .icon-color-daily{
        color: #9B4FFF;
    }
    .bg-use{
        background-color: #FFF7ED;
    }
    .icon-color-use{
        color: #FF6800;
    }
    .homems-wrapper{
        display: flex;
        justify-content: center;
        overflow: hidden;
        .homems-content{
            text-align: center;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            .title{
                // font-size: 65px;
                font-weight: 900;
                background: linear-gradient(to right, rgb(255, 24, 107) 0%, #E80075 50%, #8328F9 100%);
                -webkit-background-clip: text; /* 兼容 Safari/Chrome */
                background-clip: text;
                color: transparent; /* 隐藏原文字颜色，露出渐变 */
                font-weight: 900;
            }
            .subtitle{
                color: #334153;
                font-weight: 800;
                margin-top: 5px;
            }
            .describe{
                text-align: center;
            }
            .homems-btn{
                display: flex;
                gap: 20px;
                height: 68px;
                align-items: center;
                margin-top: 30px;
                justify-content: center;
                .the-admin{
                    background-color: rgb(255, 24, 107);
                    height: 68px;
                    display: flex;
                    align-items: center;
                    color: #fff;
                    width: 391px;
                    border-radius: 40px;
                    justify-content: center;
                    cursor: pointer;
                    .icon{
                        transition: transform 0.3s ease;
                    }
                    &:hover{
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                        .icon{
                            transform: translateX(8px)
                        }
                    }
                }
                .the-lw{
                    height: 60px;
                    width: 261px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border: 2px solid #E5E7EB;
                    border-radius: 40px;
                    cursor: pointer;
                    &:hover{
                        background-color: rgba(0, 0, 0, 0.02);
                    }
                }
            }
            .homems-assure{
                display: flex;
                gap: 20px;
                justify-content: center;
                margin-top: 40px;
                flex-wrap: wrap;
                .item{
                    height: 32px;
                    display: flex;
                    align-items: center;
                    gap: 5px;
                    border-radius: 20px;
                    padding: 0px 15px;
                    .name{
                        color: #475565;
                        font-size: 14px;
                        font-weight: 600;
                    }
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