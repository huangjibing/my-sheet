<script setup lang="ts">
import type { FloatingPosition } from '~/types/base';

interface Props {
  position: FloatingPosition;
}

const props = defineProps<Props>();

let offsetX = 0;
let offsetY = 0;
let startPos = { x: 0, y: 0 };
let isDragging = false;
let moved = false;

const getPoint = (e: MouseEvent | TouchEvent) => ('touches' in e ? e.touches[0] : e);
const wrapperRef = ref<HTMLElement>();

const onStart = (e: MouseEvent | TouchEvent) => {
  if ((e.target as HTMLElement).classList.contains('entrance-close')) return;

  const el = wrapperRef.value;
  if (!el) return;

  const point = getPoint(e);
  const rect = el.getBoundingClientRect();

  offsetX = point.clientX - rect.left;
  offsetY = point.clientY - rect.top;
  startPos = { x: point.clientX, y: point.clientY };
  moved = false;
  isDragging = true;

  window.addEventListener('mousemove', onMove);
  window.addEventListener('mouseup', onEnd);
  window.addEventListener('touchmove', onMove, { passive: false });
  window.addEventListener('touchend', onEnd);
};

const emit = defineEmits(['onClick', 'onUpdatePosition']);

const onMove = (e: MouseEvent | TouchEvent) => {
  if (!isDragging) return;

  const point = getPoint(e);
  if (!point) return;

  const dx = point.clientX - startPos.x;
  const dy = point.clientY - startPos.y;

  if (!moved && Math.sqrt(dx * dx + dy * dy) > 20) {
    moved = true;
  }

  if (e.cancelable) e.preventDefault();

  const el = wrapperRef.value;
  if (!el) return;

  const winW = window.innerWidth;
  const winH = window.innerHeight;
  const elW = el.offsetWidth;
  const elH = el.offsetHeight;

  const x = Math.min(Math.max(0, point.clientX - offsetX), winW - elW);
  const y = Math.min(Math.max(0, point.clientY - offsetY), winH - elH);

  emit('onUpdatePosition', {
    left: x,
    top: y,
    right: undefined,
  });
};

const onEnd = () => {
  if (!isDragging) return;
  isDragging = false;
  if (!moved) {
    emit('onClick');
    return;
  }

  // 👉 边缘吸附逻辑
  const winW = window.innerWidth;
  const winH = window.innerHeight;
  const elHeight = wrapperRef.value?.offsetHeight ?? 0;

  const topMargin = winH * 0.09;
  const bottomMargin = winH * 0.14;
  let top = props.position.top;
  let left = props.position.left;
  let right = props.position.right;
  let isRight = props.position.isRight;

  if (props.position.top < topMargin) {
    top = topMargin;
  }
  // if (props.position.top > winH - bottomMargin - elHeight) {
  //   top = winH - bottomMargin - elHeight;
  // }
  if (props.position.top > winH - elHeight) {
    top = winH - elHeight;
  }

  if ((props.position.left ?? 0) < winW / 2) {
    left = 0;
    right = undefined;
    isRight = false;
  } else {
    left = undefined;
    right = 0;
    isRight = true;
  }

  emit('onUpdatePosition', {
    top,
    left,
    right,
    isRight,
  });

  window.removeEventListener('mousemove', onMove);
  window.removeEventListener('mouseup', onEnd);
  window.removeEventListener('touchmove', onMove);
  window.removeEventListener('touchend', onEnd);
};
</script>

<template>
  <div
    class="floating-drag-wrapper"
    ref="wrapperRef"
    @mousedown="onStart"
    @touchstart="onStart"
    @dragstart.prevent
    :style="{
      cursor: isDragging ? 'grabbing' : 'grab',
    }"
  >
    <slot></slot>
  </div>
</template>

<style scoped lang="scss"></style>
