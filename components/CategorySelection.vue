<script setup lang="ts">
import {ArrowLeft, ArrowRight} from '@element-plus/icons-vue';
import category_1 from '@/assets/category/category_1.png';
import category_2 from '@/assets/category/category_2.png';
import category_3 from '@/assets/category/category_3.png';
import category_4 from '@/assets/category/category_4.png';
import category_5 from '@/assets/category/category_5.png';
import category_6 from '@/assets/category/category_6.png';
import category_7 from '@/assets/category/category_7.png';
import category_8 from '@/assets/category/category_8.png';

interface Props{
    isBrand?: boolean,
    toPage?: boolean,
    brandName?: string
}
const props = withDefaults(defineProps<Props>(), {
  isBrand: false,
  toPage: false,
  brandName: ''
});

const brand = {
    category: 'Brand',
    img: '',
    list: [
        "Adidas",
        "Air Jordan",
        "Alo",
        "Alexander McQueen",
        "Always",
        "Amiri",
        "Ami",
        "Ance Studios",
        "Asics",
        "Autry",
        "Balenciaga",
        "Balmain",
        "Bape",
        "Boss",
        "Bottega",
        "Broken Planet",
        "Burberry",
        "Calvin Klein",
        "Canada Goose",
        "Carhartt",
        "Cartier",
        "Casablanca",
        "Chanel",
        "Chrome Hearts",
        "Coach",
        "Converse",
        "Corteiz",
        "C.P. Company",
        "Creed",
        "Denim Tears",
        "Diesel",
        "Dior",
        "Dolce & Gabbana",
        "Dsquared2",
        "EA7",
        "Essential",
        "Evisu",
        "Fendi",
        "Ferragamo",
        "Gallery Dept",
        "Givenchy",
        "Godspeed",
        "Golden Goose",
        "Goyard",
        "Guess",
        "Gucci",
        "Hellstar",
        "Hermes",
        "Ih Nom Uh Nit",
        "Jacquemus",
        "Jordan",
        "Kenzo",
        "Lacoste",
        "Lanvin",
        "Loewe",
        "Loro Piana",
        "Louboutin",
        "Louis Vuitton",
        "Maison Margiela",
        "Marcelo Burlons",
        "Mardi",
        "Mlb",
        "Moncler",
        "Moschino",
        "New Balance",
        "New Era",
        "Nofs",
        "Nike",
        "Off White",
        "On Cloud",
        "Palm Angels",
        "Pandora",
        "Patagonia",
        "Philipp Plein",
        "Play",
        "Porsche",
        "Prada",
        "Purple",
        "Puma",
        "Ralph Lauren",
        "Ray Ban",
        "Represent",
        "Rhude",
        "Saint Laurent",
        "Salomon",
        "Spider",
        "Sp5der",
        "Stone Island",
        "Stussy",
        "Supreme",
        "Syna",
        "The North Face",
        "Timberland",
        "Tom Ford",
        "Tommy",
        "Trapstar",
        "Travis Scott",
        "Ugg",
        "Under Armour",
        "Valentino",
        "Vans",
        "Veja",
        "Versace",
        "Vivienne Westwood",
        "Vlone",
        "Warren Lotas",
        "Zegna"
    ]
}

let tags:any[] = [
    {
        category: 'Sports',
        img: category_7,
        list: [
            'All',
            'Basketball jersey',
            'Football jersey',
            'Training suit',
            'Sports equipment'
        ]
    },
    {
        category: 'Clothes',
        img: category_1,
        list: [
            'All',
            'Sweatshirt',
            'Hoodie',
            'Down Jacket',
            'Sweater',
            'Long Suit',
            'Jacket',
            'Jeans',
            'Cotton Pants',
            'Cargo Pants',
            'Training Pants',
            'Training Uniform',
            'T-shirt',
            'Polo shirt',
            'Short Suit',
            'Cargo Shorts',
            'Cotton Shorts',
            'Training Shorts',
            'Denim Shorts'
        ]
    },
    {
        category: 'Shoes',
        img: category_2,
        list: [
            'All',
            'Sneakers',
            'Casual shoes',
            'High heel',
            'Boots',
            'Slippers',
        ]
    },
    {
        category: 'Accessories',
        img: category_3,
        list: [
            'All',
            'Hat',
            'Scarf',
            'Gloves'
        ]
    },
    {
        category: 'Luxury items',
        img: category_4,
        list: [
            'All',
            'Bracelet',
            'Necklace',
            'Ring',
            'Sunglasses',
            'Accessories',
            'Perfume'
        ]
    },
    {
        category: 'Cotton items',
        img: category_5,
        list: [
            'All',
            'Underwear',
            'Socks'
        ]
    },
    {
        category: 'Leather items',
        img: category_6,
        list: [
            'All',
            'Handbag',
            'Crossbody bag',
            'Travel bag',
            'Backpack',
            'Wallet',
            'Belt'
        ]
    },
    {
        category: 'Other',
        img: category_8,
        list: [
            'All',
            'Toy',
            'Keychain',
            'Sound',
            'Headset / Air pods',
            // 'Hair dryer',
        ]
    }
]
const toTop = () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth' // 平滑滚动动画
  });
}
const router = useRouter();
const emit = defineEmits(["onSelect"]);
const firstCategory = ref('');
const lastCategory = ref('');
const activeIndex = ref('');
const menuKey = ref(0);
const handSelect = (key: string, keyPath: string[]) => {
    if (props.toPage === true && keyPath[1].split('_')[1] === '0') {
        router.push({ path: `/brand/${keyPath[1].split('_')[0]}` });
        return
    }
    if (keyPath[0].split('_')[0] === firstCategory.value && key.split('_')[0] === lastCategory.value) {
        firstCategory.value = '';
        lastCategory.value = '';
        activeIndex.value = '';
        menuKey.value++;
        emit('onSelect', '', '');
    } else {
        firstCategory.value = keyPath[0].split('_')[0];
        lastCategory.value = key.split('_')[0];
        console.info(firstCategory.value, lastCategory.value, '选中样式')
        emit('onSelect', keyPath[0].split('_')[0], key.split('_')[0]);
    }
    toTop();
}
const isMobile = ref(false);
let userAgent = '';
if (import.meta.server) {
  const headers = useRequestHeaders();
  userAgent = headers['user-agent']?.toLowerCase() || '';
} else {
  userAgent = navigator.userAgent.toLowerCase();
}
const isMobiles = /iphone|ipad|ipod|android|windows phone|mobile/i.test(userAgent);
isMobile.value = isMobiles;

onMounted(() => {
    const elList = ['Other', 'Luxury items']
    if (props.brandName) {
        for(let i in tags) {
            if (elList.includes(tags[i].category)) {
                tags.splice(parseInt(i), 1);
            }
        }
    }
})

const categoryWrapper = ref();
let timeInterval:any = null;

// 摁下
const touchstart = (abs:number) => {
    scrollLeft.value = categoryWrapper.value.scrollLeft;
    scrollLeft.value += 10 * abs;
    categoryWrapper.value.scrollLeft = scrollLeft.value
    timeInterval = setInterval(() => {
        scrollLeft.value += 10 * abs
        categoryWrapper.value.scrollLeft = scrollLeft.value
        if (scrollLeft.value >= scrollWidth.value || scrollWidth.value <= 0) {
            clearInterval(timeInterval)
            timeInterval = null;
        }
    }, 100)
}
// 抬起
const touchend = () => {
    if (timeInterval != null) {
        clearInterval(timeInterval)
        timeInterval = null;
    }
}
const scrollLeft = ref(0);
const scrollWidth = computed(() => {
    if (categoryWrapper.value) {
        return categoryWrapper.value.scrollWidth - categoryWrapper.value.clientWidth;   
    }
    return 0;
})

const handleScroll = () => {
    if (!categoryWrapper.value) return;
    // 获取当前横向滚动距离（左边缘滚动的像素值）
    scrollLeft.value = categoryWrapper.value.scrollLeft;
}

onMounted(() => {
    handleScroll();
})
</script>
<template>
    <div style="position: relative;width: 100%;">
        <div class="category-wrapper" ref="categoryWrapper" @scroll="handleScroll">
            <span class="brand-name" v-if="brandName">{{ brandName }}</span>
        <el-menu
        mode="horizontal"
        :ellipsis="false"
        :collapse-transition="false"
        :unique-opened="true"
        :hide-timeout="300"
        :menu-trigger="isMobile ? 'click' : 'hover'"
        :close-on-click-outside="true"
        :model-value="activeIndex"
        @select="handSelect"
        :key="menuKey"
        >
        <el-sub-menu :index="'Brand' + '_' + 0" v-if="isBrand">
            <template #title>
                <span>{{ brand.category }}</span>
            </template>

            <el-menu-item v-for="(curitem,curindex) in brand.list" :key="curindex" :index="curitem + '_' + 0 + '_' + curindex">
                {{ curitem }}
            </el-menu-item>
        </el-sub-menu>
        <el-sub-menu v-for="(item,index) in tags" :key="index" :index="item.category + '_' + (index + 1)">
            <template #title>
                <img v-if="item.img" class="category-img mr-5" :src="item.img" alt="">
                <span>{{ item.category }}</span>
            </template>
            <el-menu-item v-for="(curitem,curindex) in item.list" :key="curindex" :index="curitem + '_' + (index + 1) + '_' + curindex">
                {{ curitem }}
            </el-menu-item>
        </el-sub-menu>
        </el-menu>
        </div>
        <div class="arr-right" v-show="isMobile && scrollLeft < scrollWidth" @touchstart="touchstart(1)" @touchend="touchend()">
            <el-icon><ArrowRight /></el-icon>
        </div>
        <div class="arr-left" v-show="isMobile && scrollLeft > 0" @touchstart="touchstart(-1)" @touchend="touchend()">
            <el-icon><ArrowLeft /></el-icon>
        </div>
    </div>
</template>
<style lang="scss" scoped>
.category-wrapper{
    display: flex;
    .category-img{
        width: 33px;
        height: 33px;
    }
    .brand-name{
        color: #fff;
        background-color: #FF0039;
        padding: 0px 10px;
        border-radius: 10px;
        white-space: pre;
        margin-right: 10px;
        line-height: 40px;
        height: 40px;
    }
}
.category-wrapper::-webkit-scrollbar {
  display: none; /* 彻底隐藏滚动条 */
}
.arr-right{
    position: absolute;
    right: 0px;
    top: 0px;
    width: 32px;
    height: 32px;
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 50%;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
}
.arr-left{
    position: absolute;
    left: 0px;
    top: 0px;
    width: 32px;
    height: 32px;
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 50%;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
}
@media screen and (max-width: 768px) {
    .category-wrapper{
        width: 100%;
        overflow-x: auto;
        overflow-y: hidden;
        .category-img{
            width: 22.494px;
            height: 22.494px;
        }
        .brand-name{
            padding: 0px 10px;
            margin-right: 0px;
            line-height: 32px;
            height: 32px;
        }
    }
}
</style>