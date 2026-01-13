export function jumpPath(path: string, query?: Record<string, any>) {
  const route = useRoute();
  const router = useRouter();
  sessionStorage.removeItem('vigorbuybuy-spreadsheet');
  router.push({
    path,
    query,
  });
}

export function openLink(url: string, target = '_blank') {
   const a = document.createElement('a');
    a.setAttribute('href', url);
    a.setAttribute('target', target);
    a.setAttribute('id', 'camnpr');
    document.body.appendChild(a);
    a.click();
};

/**
 * 复制
 * @param text 复制文本
 */
export async function handleCopy (text: string) {
  // 创建临时文本框
  const textarea = document.createElement('textarea');
  textarea.value = text;
  textarea.style.position = 'fixed'; // 避免滚动影响
  document.body.appendChild(textarea);
  // 选中并复制
  textarea.select();
  const success = document.execCommand('copy');
  // 清理临时元素
  document.body.removeChild(textarea);
  ElMessage({
    message: 'Copied!',
    type: 'success',
    grouping: true,
    // customClass: 'base-ui-message',
    duration: 2000,
  });
};