<script setup lang="ts">
import Grids2 from '@/assets/blog/grids-2.webp'
</script>
<template>
    <div class="min-h-screen bg-[#121212]">
        <div class="relative h-[400px] sm:h-[500px] bg-[#121212]">
            <el-image fit="cover" class="object-cover opacity-40" style="position: absolute; height: 100%; width: 100%; inset: 0px; color: transparent;" loading="lazy" :src="Grids2" />
            <div class="absolute inset-0 bg-gradient-to-t from-[#121212] to-transparent"></div>
            <div class="relative h-full max-w-4xl mx-auto px-4 sm:!px-6 lg:!px-8 flex flex-col justify-end pb-12">
                <div class="flex items-center gap-2 text-slate-400 text-sm mb-4">
                    <span class="pointer" @click="jumpPath('/')">Home</span>
                    <span>/</span>
                    <span class="pointer" @click="jumpPath('/blog')">Blog</span>
                    <span>/</span>
                    <span class="text-white">Beginner</span>
                </div>

                <div class="mb-4">
                    <span class="px-3 py-1 bg-[#FF186B] text-white rounded-full text-sm font-semibold">
                        Guides
                    </span>
                </div>

                <h1 class="text-3xl sm:text-4xl lg:text-5xl font-black text-white mb-4 !leading-tight">What is Vigorbuy? Complete Beginner's Guide to Chinese Shopping Agents (2025)</h1>

                <div class="flex flex-wrap items-center gap-4 text-slate-300 text-sm">
                    <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-fangxunrenyuan"></i>
                        <span>Vigorbuy Sheet Team</span>
                    </div>

                     <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-rili"></i>
                        <span>December 25, 2025</span>
                    </div>

                     <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-shijian"></i>
                        <span>7 min read</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="bg-gray-700 rounded-2xl p-6 mb-8 border-l-4 border-[#FF186B]">
                <p class="text-lg text-slate-300 leading-relaxed font-medium">
                    New to Vigorbuy? Learn what shopping agents are, how Vigorbuy works, what products you can order, and step-by-step instructions to place your first order.
                </p>
            </div>

            <h2 class="text-4xl font-black text-white mt-8 mb-6">
                What is Vigorbuy? Complete Beginner's Guide
            </h2>

            <p class="text-slate-300 leading-relaxed mb-4">
                If you've heard about Vigorbuy but aren't sure what it is or how it works, this guide is for you. We'll explain everything you need to know to start shopping from Chinese platforms like Taobao, 1688, and Weidian.
            </p>

            <h2 class="text-3xl font-black text-white !mt-12 mb-6 border-b border-white/10 pb-2">
                What is Vigorbuy?
            </h2>

            <p class="text-slate-300 leading-relaxed mb-4">
                <strong class="font-bold text-white">Vigorbuy is a Chinese shopping agent</strong>
                 (also called a buying agent or proxy service). It acts as an intermediary between you and Chinese e-commerce platforms that don't ship internationally.                
            </p>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                The Problem Vigorbuy Solves
            </h3>
            <p class="text-slate-300 leading-relaxed mb-4">
                Chinese platforms like Taobao, 1688, and Weidian offer amazing products at incredible prices. However, they have barriers for international buyers:
            </p>
            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">No international shipping</strong>
                       - Most sellers only ship within China
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Chinese language only</strong>
                       - Websites are entirely in Chinese
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Chinese payment required</strong>
                       - Need Alipay or WeChat Pay
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">No customer support</strong>
                       - Can't communicate with sellers
                </li>
            </ul>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                How Vigorbuy Helps
            </h3>
            <p class="text-slate-300 leading-relaxed mb-4">Vigorbuy removes these barriers by:</p>

            <ol class="list-decimal pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Purchasing on your behalf</strong>
                     - They buy from Chinese sellers
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Receiving items</strong>
                      - Products ship to their warehouse in China
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Quality inspection</strong>
                      - They check items before forwarding
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">International shipping</strong>
                      - They send packages to you worldwide
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Customer support</strong>
                       - English-speaking help available
                </li>
            </ol>


            <BrowseTheSpreadsheet />
        </div>
    </div>
</template>
<style lang="scss" scoped>
</style>