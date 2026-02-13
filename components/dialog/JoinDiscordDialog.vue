<script setup lang="ts">
const emit = defineEmits(['onClose']);

const closeDialog = () => {
    emit('onClose');
}
const openDiscord = () => {
    closeDialog();
    openLink('https://discord.com/invite/nmRxUPDK9m')
}
</script>
<template>
    <div class="absolute border border-[#000000] rounded-[10px] w-11/12 sm:w-[500px] z-10 p-[20px] bg-[#ffffff] top-2/4 left-2/4 translate-auto">
        <div class="text-2xl text-center">WHY JOIN DISCORD</div>

        <i class="text-3xl icon iconfont icon-guanbi absolute pointer top-[10px] right-[20px]" @click="closeDialog()"></i>

        <p class="mt-10">
            Send product photos to our customer service, and they'll help you find what you're looking for！
        </p>

        <p class="mt-10">
            Ready to place an order? contact our customer service on discord to get a more discount！
        </p>

        <div class="mt-8 p-[10px] bg-[#000000] text-white rounded-[8px] text-center pointer" @click="openDiscord">
            Join discord
        </div>
    </div>
</template>
<style lang="scss" scoped>
.translate-auto{
    transform: translateX(-50%) translateY(-50%);
}
</style>