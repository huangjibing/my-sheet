<script setup lang="ts">
// bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 text-white
</script>
<template>
    <div class="bg-gray-900 text-white">
        <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 pt-24 pb-16">
            <div class="text-center max-w-3xl mx-auto">
                <div class="inline-flex items-center gap-2 px-4 py-2 bg-white/10 backdrop-blur-sm rounded-full text-sm mb-6">
                    <span class="w-2 h-2 rounded-full animate-pulse" style="background-color: rgb(255, 24, 107);">
                    </span>
                    QC Picture Search
                </div>

                <h1 class="text-4xl sm:text-5xl lg:text-6xl font-bold mb-6 leading-tight">
                    Find QC Pictures
                    <span class="block" style="color: rgb(255, 24, 107);">
                        Before You Buy
                    </span>
                </h1>

                <p class="text-lg sm:text-xl text-gray-300 mb-10 max-w-2xl mx-auto">
                    Search quality control photos from Taobao, 1688 & Weidian. See exactly what arrives at the warehouse.
                </p>

                <form action="" class="max-w-2xl mx-auto">
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-5 flex items-center pointer-events-none"></div>

                        <input placeholder="Paste Taobao, 1688, or Weidian link..."
                         type="text" class="w-full pl-14 pr-32 py-5 bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl text-white placeholder-gray-400 focus:outline-none focus:border-transparent transition-all text-lg"
                         style="--tw-ring-color: #ff186b;">

                         <button type="submit"
                         class="absolute right-2 top-1/2 -translate-y-1/2 px-6 py-3 text-white font-semibold rounded-xl disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                         style="background: linear-gradient(135deg, rgb(255, 24, 107) 0%, rgb(224, 21, 96) 100%); box-shadow: rgba(255, 24, 107, 0.4) 0px 10px 25px -5px;">
                         Search
                         </button>
                    </div>
                </form>

                <div class="flex items-center justify-center gap-6 mt-8 text-sm text-gray-400">
                    <span>Supported:</span>
                    <div class="flex items-center gap-4">
                        <span class="px-3 py-1 bg-white/5 rounded-lg">Taobao</span>
                        <span class="px-3 py-1 bg-white/5 rounded-lg">1688</span>
                        <span class="px-3 py-1 bg-white/5 rounded-lg">Weidian</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="bg-white">
            <main class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                <div class="text-center py-20">
                    <div class="w-24 h-24 mx-auto mb-8 rounded-3xl bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center shadow-inner">
                        <i class="icon iconfont icon-zanwutupian text-slate-400" style="font-size: 46px;"></i>
                    </div>

                    <h3 class="text-2xl font-bold text-gray-900 mb-3">
                        Search for QC Pictures
                    </h3>
                    <p class="text-gray-500 max-w-md mx-auto text-lg">Paste a product link from Taobao, 1688, or Weidian to view warehouse QC photos.</p>
                </div>

                <div class="grid md:grid-cols-3 gap-6 mt-16">
                    <div class="bg-white rounded-2xl p-6 shadow-lg shadow-gray-200/50 border border-gray-100">
                        <div class="w-12 h-12 rounded-xl flex items-center justify-center mb-4" style="background-color: rgba(255, 24, 107, 0.1);">
                            <i class="icon iconfont icon-queding text-rose-500" style="font-size: 26px;"></i>
                        </div>
                        <h3 class="font-bold text-gray-900 mb-2">Quality Verified</h3>
                        <p class="text-gray-500 text-sm">See real photos taken at the warehouse before shipping internationally.</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-lg shadow-gray-200/50 border border-gray-100">
                        <div class="w-12 h-12 rounded-xl flex items-center justify-center mb-4" style="background-color: rgba(255, 24, 107, 0.1);">
                            <i class="icon iconfont icon-lianjie text-rose-500" style="font-size: 26px;"></i>
                        </div>
                        <h3 class="font-bold text-gray-900 mb-2">Easy to Use</h3>
                        <p class="text-gray-500 text-sm">Just paste any product link - we automatically extract the ID.</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-lg shadow-gray-200/50 border border-gray-100">
                        <div class="w-12 h-12 rounded-xl flex items-center justify-center mb-4" style="background-color: rgba(255, 24, 107, 0.1);">
                            <i class="icon iconfont icon-fenxiang text-rose-500" style="font-size: 26px;"></i>
                        </div>
                        <h3 class="font-bold text-gray-900 mb-2">Share Results</h3>
                        <p class="text-gray-500 text-sm">Copy the link and share QC photos with friends or communities.</p>
                    </div>
                </div>
            </main>
        </div>
    </div>
</template>
<style lang="scss" scoped>
</style>