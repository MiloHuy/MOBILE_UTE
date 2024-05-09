import { EPaymentMethod, EStatusPayment } from "../../models/payments/interface";
import { IResponse } from "../interface";

export interface IRequestCreatePayment {
  body: {
    orderId: string,
    userId: string,
    addressOrder: string,
  }
}

export interface IRequestCreatePaymentForProduct {
  body: {
    userId: string;
    receiverName: string;
    phone: number;
    productId: string;
    brandId: string;
    productPrice: number;
    productQuanitiOrder: number;
    productSize: string;
    addressOrder: string;
  }
}

export interface IResponseCreatePayment extends IResponse {
  _id?: string,
  method?: EPaymentMethod,
  orderId?: string,
  userId?: string,
  status?: EStatusPayment,
  addressOrder?: string,
}
export interface ICreatePayment {
  body: {
    method: EPaymentMethod,
    orderId: string,
    userId: string,
    status: EStatusPayment,
    addressOrder?: string,
  }
}

export interface IRequestStatusOrdered {
  body: {
    orderId: string,
    status: EStatusPayment,
    addressOrder: string,
  }
}

export interface IRequestGetPaymentByField {
  userId?: string,
  status?: EStatusPayment,
  orderId?: string,
  method?: EPaymentMethod,
  addressOrder?: string,
}