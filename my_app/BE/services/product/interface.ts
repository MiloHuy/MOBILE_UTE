import { IResponse } from "../interface";

export interface IRequestCreateProduct {
  query: {
    productName: string;
    productImg: string;
    price: number;
    size: string;
    rate: number;
    description: string;
    brand: string;
    category: string;
    quantity: number;
  }
}

export interface IResponseGetProductById extends IResponse {
  product?: {
    _id: string;
    productName: string;
    productImg: string;

    brand_id: string;
    order_id: string;
    category_id: string;
    discount_id: string;
    user_id: string;

    price: number[];
    size: string[];
    quantity: number;
    productRate: number;
    description: string;
    isLiked: boolean;
  }
}

export interface IRequestGetProductByField {
  query: {
    _id: string;
    productName: string;
    productImg: string;

    brand_id: string;
    order_id: string;
    category_id: string;
    discount_id: string;
    user_id: string;

    price: number[];
    size: string[];
    quantity: number;
    productRate: number;
    description: string;
    isLiked: boolean;
  }
}