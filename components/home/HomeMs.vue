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
                    <span class="name">10,000+ Products</span>
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
        background-color: lab(98.1563 -5.60117 2.75915);
    }
    .icon-color-products{
        color: lab(70.5521 -66.5147 45.8073);
    }
    .bg-photos{
        background-color: lab(96.492 -1.14644 -5.11479);
    }
    .icon-color-photos{
        color: lab(54.1736 13.3369 -74.6839);
    }
    .bg-daily{
        background-color: lab(97.1627 2.99937 -4.13398);
    }
    .icon-color-daily{
        color: lab(52.0183 66.11 -78.2316);
    }
    .bg-use{
        background-color: lab(97.7008 1.53735 5.90649);
    }
    .icon-color-use{
        color: lab(64.272 57.1788 90.3583);
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
                background: linear-gradient(to right, rgb(255, 24, 107) 0%, lab(49.5493 79.8381 2.31768) 50%, lab(43.0295 75.21 -86.5669) 100%);
                -webkit-background-clip: text; /* 兼容 Safari/Chrome */
                background-clip: text;
                color: transparent; /* 隐藏原文字颜色，露出渐变 */
            }
            .subtitle{
                color: lab(27.1134% -.956401 -12.3224);
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
                    border: 2px solid lab(91.6229 -0.159115 -2.26791);
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
                        color: lab(35.6337 -1.58697 -10.8425);
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