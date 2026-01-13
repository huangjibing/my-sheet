import { useEventBus } from '@vueuse/core';
import type { MainScrollEventOptions } from '@/types/eventBus';

// main scroll
export const MainScroll = 'mainScroll';
export const mainScrollEvent = useEventBus<MainScrollEventOptions>(MainScroll);