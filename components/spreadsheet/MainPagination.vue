<script setup lang="ts">
interface Props {
    page: number,
    size: number,
    total: number,
}
const props = defineProps<Props>();
const emit = defineEmits(["changePage"]);
const maxPage = computed(() => {
    return Math.ceil(props.total / props.size)
})
const changePage = (value:number) => {
    if ((value > 0 && props.page >= maxPage.value) || (value < 0 && props.page <= 1)) {
        return;
    }
    emit('changePage', value)
}
</script>
<template>
    <div class="mainpagination-wrappe border border-white/10 bg-white/5">
        <div class="font-12 text-gray-500 bold-600">
            <span>Showing</span>
            <span class="text-c92910">&nbsp;{{ size }}</span>
            <span>&nbsp;products on page</span>
            <span>&nbsp;{{ page }}</span>
            <!-- <span>&nbsp;Quantity of goods:{{ total }}</span> -->
        </div>

        <div class="btn">
            <div class="previous" :class="{'disable': page <= 1, 'unblock-previous inset-0 theme-btn rounded-full': page > 1}"  @click="changePage(-1)">
                <i class="icon iconfont icon-xiangzuojiantou font-12"></i>
                <span>Previous</span>
            </div>
            <div class="page text-white inset-0 theme-btn-selected rounded-full border border-[#ff0033]/40 bold-600">
                <span>Page&nbsp;</span>
                <span>{{ page }}</span>
            </div>
            <div class="next" :class="{'disable': page >= maxPage, 'unblock-next inset-0 theme-btn rounded-full': page < maxPage}" @click="changePage(1)">
                <span>Next</span>
                <i class="icon iconfont icon-xiangyoujiantou font-12"></i>
            </div>
        </div>
    </div>
</template>
<style lang="scss" scoped>
.text-c92910{
    color: #c92910;
}
.disable{
    background-image: linear-gradient(to right, #D0D5DC 0%, #97A1AF 100%);
    cursor: not-allowed;
}
.unblock-previous{
    // background-image: linear-gradient(to right, rgb(201, 41, 16) 0%, #C40003 100%);
    cursor: pointer;
     &:hover{
        transform: scale(1.05);
        // background: linear-gradient(to right, rgb(255, 24, 107) 0%, #C40003 100%); /* 粉到红渐变 */
        // .icon{
        //     transform: translateX(-3px)
        // }
    }
}
.unblock-next{
    // background-image: linear-gradient(to right, rgb(201, 41, 16) 0%, #C40003 100%);
    cursor: pointer;
     &:hover{
        transform: scale(1.05);
        // background: linear-gradient(to right, rgb(255, 24, 107) 0%, #C40003 100%); /* 粉到红渐变 */
        // .icon{
        //     transform: translateX(3px)
        // }
    }
}
.mainpagination-wrappe{
    display: flex;
    justify-content: space-between;
    padding: 30px;
    border-radius: 16px;
    align-items: center;
    .btn{
        height: 52px;
        display: flex;
        gap: 10px;
        div{
            height: 100%;
            display: flex;
            align-items: center;
            padding: 0px 15px;
            border-radius: 12px;
        }
        .previous{
            color: #fff;
            font-weight: 14px;
            font-weight: 600;
            .icon{
                margin-right: 5px;
                transition: transform 0.3s ease;
            }
            transition: transform 0.3s ease;
        }
        .page{
            // background-image: linear-gradient(to right, #F1E8FF 0%, #FCE7F3 100%);
            // border: 1px solid #CD2A0D;
            padding: 0px 24px;
        }
        .next{
            color: #fff;
            font-weight: 14px;
            font-weight: 600;
            .icon{
                margin-left: 5px;
                transition: transform 0.3s ease;
            }
            transition: transform 0.3s ease;
        }
    }
}
@media (max-width: 768px) {
    .mainpagination-wrappe{
        flex-direction: column;
        .btn{
            margin-top: 12px;
        }
    }
}
</style>