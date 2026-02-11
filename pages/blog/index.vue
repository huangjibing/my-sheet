<script setup lang="ts">
import BlogLc from '@/assets/blog/blog-lc.webp'
import type { GirdsItem } from "~/types/base";
import Grids1 from '@/assets/blog/grids-1.webp';
import Grids2 from '@/assets/blog/grids-2.webp';
import Grids3 from '@/assets/blog/grids-3.webp';
import Grids4 from '@/assets/blog/grids-4.webp';
import Grids5 from '@/assets/blog/grids-5.webp';
import Grids6 from '@/assets/blog/grids-6.webp';
const gridsList = computed<GirdsItem[]>(() => {
    return [
        {
            page: '/blog/vigorbuy-shipping-guide',
            image: Grids1,
            tag: 'Guides',
            time: '8',
            title: 'Vigorbuy Shipping Guide: Best Lines & Methods for Every Country (2025)',
            content: 'Complete guide to Vigorbuy shipping options. Learn which shipping line to use for your country, estimated delivery times, and how to save on shipping costs.'
        },
        {
            page: '/blog/what-is-vigorbuy',
            image: Grids2,
            tag: 'Beginner',
            time: '7',
            title: "What is Vigorbuy? Complete Beginner's Guide to Chinese Shopping Agents (2025)",
            content: 'New to Vigorbuy? Learn what shopping agents are, how Vigorbuy works, what products you can order, and step-by-step instructions to place your first order.'
        },
        {
            page: '/blog/vigorbuy-coupons-guide',
            image: Grids3,
            tag: 'Savings',
            time: '5',
            title: 'Vigorbuy Coupons Guide: How to Find, Use & Maximize Savings (2025)',
            content: 'Complete guide to Vigorbuy coupons and discounts. Learn where to find coupon codes, how to apply them, and tips to maximize your savings on every order.'
        },
        {
            page: '/blog/complete-guide-buying-from-taobao-2025',
            image: Grids4,
            tag: 'Guides',
            time: '12',
            title: 'Complete Guide to Buying from Taobao in 2025: Save 50-80% on Authentic Products',
            content: "Learn how to shop from Taobao, China's largest marketplace, and save massive amounts on clothing, electronics, and more. Complete beginner's guide with tips from experts."
        },
        {
            page: '/blog/1688-vs-taobao-vs-weidian-comparison-guide',
            image: Grids5,
            tag: 'Comparisons',
            time: '10',
            title: '1688 vs Taobao vs Weidian: Which Chinese Shopping Platform is Best for You?',
            content: "Detailed comparison of China's top three shopping platforms. Learn which platform offers the best deals, quality, and products for your needs."
        },
        {
            page: '/blog/how-to-avoid-counterfeit-products-chinese-shopping',
            image: Grids6,
            tag: 'Safety & Tips',
            time: '8',
            title: 'How to Avoid Counterfeit Products When Shopping from China: Expert Guide',
            content: 'Learn how to identify authentic products and avoid fakes when buying from Chinese platforms. Essential tips for safe shopping.'
        }
    ]
})
</script>
<template>
    <div class="blog-wrapper max-w-7xl mx-auto px-4 sm:!px-6 lg:!px-8 pt-12">
        <div class="mb-4 font-14">
            <span class="home text-gray-500 pointer" @click="jumpPath('/')">
                <i class="icon iconfont icon-shouye"></i>
                <span class="ml-3">Home</span>
            </span>
            <i class="icon iconfont icon-xiangyoujiantou ml-5 font-12 text-gray-500"></i>
            <span class="ml-5 text-white">Guides</span>
        </div>
        <div class="animate-fade-in-down blog-header flex mb-4">
            <div class="tips bold-500">
                <i class="icon iconfont icon-shu bold-700"></i>
                <span class="ml-2">Vigorbuy Shopping Guides</span>
            </div>
        </div>

        <h1 class="animate-fade-in-up text-center text-4xl sm:text-5xl lg:text-6xl font-black mb-4 text-gradient-pink">
            Shopping Guides
        </h1>

        <p class="animate-fade-in-up text-center text-lg max-w-3xl mx-auto mb-12 text-gray-500">
            Expert guides on shipping, declarations, coupons, and shopping from Taobao, 1688, and Weidian.
        </p>

        <div class="mb-12">
            <div class="blog-card border border-white/10 bg-white/5">
                <div class="item" style="flex: 1;">
                    <el-image fit="cover" class="product-img" style="height: 100%;" loading="lazy" :src="BlogLc" />
                </div>
                <div class="item p-8 lg:!p-12">
                    <div class="flex items-center gap-4 text-sm text-slate-500 mb-4">
                        <span class="px-3 py-1 bg-purple-500/10 text-purple-400 rounded-full font-medium">Grids</span>

                       <div class="flex items-center gap-1">
                        <i class="icon iconfont icon-rili"></i>
                        December 20, 2025
                       </div>
                       <div class="flex items-center gap-1">
                        <i class="icon iconfont icon-shijian"></i>
                        6 min read
                       </div>
                    </div>
                    <h2 class="text-3xl font-bold mb-4 leading-tight text-white">How to Declare on Vigorbuy: Complete Customs Declaration Guide 2025</h2>
                    <p class="text-slate-400 mb-6 leading-relaxed">Learn the correct declaration values for each country to avoid customs fees and delays. Country-specific thresholds for USA, UK, Canada, Germany, and more.</p>

                    <div class="guide-btn px-6 py-3 gap-2 bg-gradient-to-r from-[#ff3eaa] to-[#008cff]" @click="jumpPath('/blog/how-to-declare-on-vigorbuy')">
                        <span>Read Full Guide</span>
                        <i class="icon iconfont icon-youjiantou"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="mb-12">
            <h2 class="text-2xl font-bold mb-6 text-gray-500">All Guides</h2>

            <div class="grids-list">
                <GridsItem
                v-for="(item,index) in gridsList"
                :grids="item"
                :key="index" />
            </div>
        </div>

        <BrowseTheSpreadsheet />
    </div>
</template>
<style lang="scss" scoped>
@keyframes fadeInDown{
    0%{
        opacity: 0;
        transform: translateY(-40px);
    }
    100%{
        opacity: 1;
        transform: translateY(0px);
    }
}
@keyframes fadeInUp {
    0%{
        opacity: 0;
        transform: translateY(40px);
    }
    100%{
        opacity: 1;
        transform: translateY(0px);
    }
}
.animate-fade-in-down{
    animation: .6s ease-out forwards fadeInDown;
}
.animate-fade-in-up{
    animation: .6s ease-out forwards fadeInUp;
}
.blog-wrapper{
    padding-top: 30px;
    .blog-header{
        justify-content: center;
        gap: 10px;
        .to-home{
            &:hover{
                color: rgb(255, 24, 107);
            }
        }
        .tips{
            background-color: lab(55.8824 81.016 18.8158 / 0.1);
            height: 36px;
            display: flex;
            align-items: center;
            border-radius: 20px;
            color: rgb(255, 24, 107);
            padding: 0px 20px;
        }
    }
    .text-gradient-pink{
        -webkit-text-fill-color: transparent;
        background: linear-gradient(135deg, #ff186b, #a855f7);
        background-clip: text;
    }
    .blog-card{
        border-radius: 24px;
        overflow: hidden;
        display: flex;
        .item{
            width: 50%;
            .guide-btn{
                display: inline-flex;
                border-radius: 8px;
                // background-color: rgba($color: #ff186b, $alpha: 1);
                filter: brightness(1.1);
                color: #fff;
                cursor: pointer;
                &:hover{
                    filter: brightness(0.92);
                }
            }
        }
    }
    .grids-list{
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
    }
}
@media (max-width: 992px) {
    .grids-list{
        grid-template-columns: repeat(2, 1fr) !important;
        gap: 10px !important;
    }
}
@media screen and (max-width: 768px) {
    .blog-wrapper{
        .blog-card{
            flex-direction: column;
            .item{
                width: 100%;
            }
        }
        .grids-list{
            grid-template-columns: repeat(1, 1fr) !important;
            gap: 10px !important;
        }
    }
}
</style>