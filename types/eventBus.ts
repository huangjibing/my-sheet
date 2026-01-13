export interface MainScrollEventOptions {
  type: string;
  data: {
    scrollTop: number;
    scrollHeight: number;
    clientHeight: number;
    isUp?: boolean;
  };
}