import { defineStore } from 'pinia';

export const useUserStore = defineStore('user', () => {
    const isMobile = ref(false);
    const setIsMobile = (status: boolean) => {
        isMobile.value = status;
    };

    return {
        isMobile,
        setIsMobile
    }
})