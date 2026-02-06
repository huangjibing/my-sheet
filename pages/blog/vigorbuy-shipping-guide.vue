<script setup lang="ts">
import Grids1 from '@/assets/blog/grids-1.webp'
</script>
<template>
    <div class="min-h-screen bg-[#0B1120]">
        <div class="relative h-[400px] sm:h-[500px] bg-[#111827]">
            <el-image fit="cover" class="object-cover opacity-40" style="position: absolute; height: 100%; width: 100%; inset: 0px; color: transparent;" loading="lazy" :src="Grids1" />
            <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] to-transparent"></div>
            <div class="relative h-full max-w-4xl mx-auto px-4 sm:!px-6 lg:!px-8 flex flex-col justify-end pb-12">
                <div class="flex items-center gap-2 text-slate-400 text-sm mb-4">
                    <a href="/">Home</a>
                    <span>/</span>
                    <a href="/blog">Blog</a>
                    <span>/</span>
                    <span class="text-white">Guides</span>
                </div>

                <div class="mb-4">
                    <span class="px-3 py-1 bg-[#FF186B] text-white rounded-full text-sm font-semibold">
                        Guides
                    </span>
                </div>

                <h1 class="text-3xl sm:text-4xl lg:text-5xl font-black text-white mb-4 !leading-tight">Vigorbuy Shipping Guide: Best Lines & Methods for Every Country (2025)</h1>

                <div class="flex flex-wrap items-center gap-4 text-slate-300 text-sm">
                    <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-fangxunrenyuan"></i>
                        <span>Vigorbuy Sheet Team</span>
                    </div>

                     <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-rili"></i>
                        <span>December 22, 2025</span>
                    </div>

                     <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-shijian"></i>
                        <span>8 min read</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="bg-[#1E293B] rounded-2xl p-6 mb-8 border-l-4 border-[#FF186B]">
                <p class="text-lg text-slate-300 leading-relaxed font-medium">
                    Complete guide to Vigorbuy shipping options. Learn which shipping line to use for your country, estimated delivery times, and how to save on shipping costs.
                </p>
            </div>

            <h2 class="text-4xl font-black text-white mt-8 mb-6">
                Vigorbuy Shipping Guide: Everything You Need to Know
            </h2>

             <p class="text-slate-300 leading-relaxed mb-4">
                Choosing the right shipping method can make or break your Vigorbuy experience. This comprehensive guide covers the best shipping lines for every country, delivery times, and tips to save money.
            </p>

            <h2 class="text-3xl font-black text-white !mt-12 mb-6 border-b border-white/10 pb-2">
                Understanding Vigorbuy Shipping
            </h2>

            <p class="text-slate-300 leading-relaxed mb-4">
                When you order through Vigorbuy, items first arrive at their warehouse in China. From there, you choose how to ship them internationally. The right choice depends on:
            </p>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                   Your country/location
                </li>

                <li class="text-slate-300 leading-relaxed">
                    Package weight and size
                </li>

                <li class="text-slate-300 leading-relaxed">
                    Budget and timeline
                </li>

                <li class="text-slate-300 leading-relaxed">
                    Contents of your shipment
                </li>
            </ul>

            <h2 class="text-3xl font-black text-white !mt-12 mb-6 border-b border-white/10 pb-2">
                Shipping Recommendations by Region
            </h2>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                United Kingdom
            </h3>
            <p class="text-slate-300 leading-relaxed mb-4">
                <strong class="font-bold text-white">Best Options:</strong>
            </p>
            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">UK-Yodel</strong>
                      - Reliable, tax-efficient
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Royal Mail</strong>
                      - Trusted delivery service
                </li>
            </ul>
            <p class="text-slate-300 leading-relaxed mb-4">
                <strong class="font-bold text-white">Tips:</strong>
            </p>
            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    Always declare $17.90 with UK Line B
                </li>
                <li class="text-slate-300 leading-relaxed">
                    Yodel offers good tracking
                </li>
                <li class="text-slate-300 leading-relaxed">
                    Royal Mail may be slower but reliable
                </li>
            </ul>

            <p class="text-slate-300 leading-relaxed mb-4">
                <strong class="font-bold text-white">Estimated Delivery:</strong>
                 10-20 days
            </p>

            <BrowseTheSpreadsheet />
        </div>
    </div>
</template>
<style lang="scss" scoped>
</style>