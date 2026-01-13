export interface Product {
  id: number;
  typeName: string;
  parentTypeName: string;
  goodsTitle: string;
  price: number;
  qcImage: string[];
  image: string;
  vigorbuyUrl: string;
  offerId: string;
  discountedPrice: number;
  discount: number;
  tags: string[];
  brand: string;
  tag: string;
}

export interface TabItem {
  label: string;
  key: string | number;
  content?: any;
  icon?: string;
}

export interface FloatingPosition {
  top: number;
  left?: number;
  right?: number;
  isRight?: boolean;
}

