<script setup lang="ts">
import BlogLc from '@/assets/blog/blog-lc.webp'
</script>
<template>
    <div class="min-h-screen bg-[#0B1120]">
        <div class="relative h-[400px] sm:h-[500px] bg-[#111827]">
            <el-image fit="cover" class="object-cover opacity-40" style="position: absolute; height: 100%; width: 100%; inset: 0px; color: transparent;" loading="lazy" :src="BlogLc" />
            <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] to-transparent"></div>
            <div class="relative h-full max-w-4xl mx-auto px-4 sm:!px-6 lg:!px-8 flex flex-col justify-end pb-12">
                <div class="flex items-center gap-2 text-slate-400 text-sm mb-4">
                    <span class="pointer" @click="jumpPath('/')">Home</span>
                    <span>/</span>
                    <span class="pointer" @click="jumpPath('/blog')">Blog</span>
                    <span>/</span>
                    <span class="text-white">Grids</span>
                </div>

                <div class="mb-4">
                    <span class="px-3 py-1 bg-[#FF186B] text-white rounded-full text-sm font-semibold">
                        Guides
                    </span>
                </div>

                <h1 class="text-3xl sm:text-4xl lg:text-5xl font-black text-white mb-4 !leading-tight">How to Declare on Vigorbuy: Complete Customs Declaration Guide 2025</h1>

                <div class="flex flex-wrap items-center gap-4 text-slate-300 text-sm">
                    <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-fangxunrenyuan"></i>
                        <span>Vigorbuy Sheet Team</span>
                    </div>

                     <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-rili"></i>
                        <span>December 20, 2025</span>
                    </div>

                     <div class="flex items-center gap-2">
                        <i class="icon iconfont icon-shijian"></i>
                        <span>6 min read</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="bg-[#1E293B] rounded-2xl p-6 mb-8 border-l-4 border-[#FF186B]">
                <p class="text-lg text-slate-300 leading-relaxed font-medium">
                    Learn the correct declaration values for each country to avoid customs fees and delays. Country-specific thresholds for USA, UK, Canada, Germany, and more.
                </p>
            </div>

            <h2 class="text-4xl font-black text-white mt-8 mb-6">
                How to Declare on Vigorbuy: Complete Customs Declaration Guide
            </h2>

            <p class="text-slate-300 leading-relaxed mb-4">
                When shipping internationally through Vigorbuy, properly declaring your items is crucial for smooth customs clearance. This guide covers everything you need to know about declaration values for different countries.
            </p>

            <h2 class="text-3xl font-black text-white mt-12 mb-6 border-b border-white/10 pb-2">
                What is Declaration?
            </h2>

            <p class="text-slate-300 leading-relaxed mb-4">
                Declaration refers to the process customs authorities use to assess the value of your shipment. When you ship items internationally, you must declare their value to customs. This declared value determines:
            </p>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    Whether you pay import taxes/duties
                </li>

                <li class="text-slate-300 leading-relaxed">
                    How your package is processed at customs
                </li>

                <li class="text-slate-300 leading-relaxed">
                    The level of inspection your package receives
                </li>
            </ul>

            <h2 class="text-3xl font-black text-white mt-12 mb-6 border-b border-white/10 pb-2">
                Why Accurate Declaration Matters
            </h2>

            <p class="text-slate-300 leading-relaxed mb-4">
                Proper declaration ensures:
            </p>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Smooth customs processing</strong>
                     - No unexpected delays
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Avoid additional fees</strong>
                     - Stay under tax thresholds
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Prevent seizures</strong>
                     - Overly low declarations can cause problems
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Legal compliance</strong>
                     - Meet import regulations
                </li>
            </ul>

            <h2 class="text-3xl font-black text-white mt-12 mb-6 border-b border-white/10 pb-2">
                Country-Specific Declaration Guidelines
            </h2>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                United States
            </h3>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Tax-free threshold:</strong>
                     Up to $800
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Recommended declaration:</strong>
                     Total value up to $135
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Best shipping lines:</strong>
                     US Air LDT, US Tax-Free Line
                </li>
            </ul>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                United Kingdom
            </h3>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Tax-free threshold:</strong>
                      £135 (approximately $170)
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Recommended declaration:</strong>
                     $17.90 with UK Line B
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Best shipping lines:</strong>
                      UK-Yodel, Royal Mail
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Pro tip:</strong>
                     Always declare exactly $17.90 with UK Line B for best results
                </li>
            </ul>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                Canada
            </h3>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Tax-free threshold:</strong>
                     CAD $20 (approximately $14 USD)
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Recommended declaration:</strong>
                      Values under $14
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Note:</strong>
                       Canada has a very low threshold - be careful with declarations
                </li>
            </ul>

            <h3 class="text-2xl font-bold text-white mt-8 mb-4">
                Germany
            </h3>

            <ul class="list-disc pl-6 my-6 space-y-2">
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Tax-free threshold:</strong>
                     €150 for customs, €22 for VAT
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Recommended declaration:</strong>
                     $16-$21 with Line B (up to $50 max)
                </li>
                <li class="text-slate-300 leading-relaxed">
                    <strong class="font-bold text-white">Best shipping lines:</strong>
                        DHL Tax-Free Line, EU tariffless lines
                </li>
            </ul>

            <BrowseTheSpreadsheet />
        </div>
    </div>
</template>
<style lang="scss" scoped>
</style>