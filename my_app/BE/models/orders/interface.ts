import { Document } from "mongoose";

export enum EOrderStatus {
  NOT_ORDER = 'NOT_ORDER',
  ORDERED = 'ORDERED',
  PREPARING = 'PREPARING',
  DELIVERING = 'DELIVERING',
  DELIVERED = 'DELIVERED',
  ABORTED = 'ABORTED'
}

export interface IOrderSchema extends Document {
  userId: string;
  productId: string[];
  brandId: string[];
  productPrice: number[];
  productQuanitiOrder: number[];
  productSize: string[];
  addressId: string;
  status: EOrderStatus
  confirm: boolean;
}
