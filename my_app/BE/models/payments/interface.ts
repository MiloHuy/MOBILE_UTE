import { Document } from "mongoose";

export enum EPaymentMethod {
  COD = 'COD',
  OTHER = 'OTHER'
}

export enum EStatusPayment {
  NOT_PAYMENT = 'NOT_PAYMENT',
  PAID = 'PAID'
}

export interface IPaymentSchema extends Document {
  method: EPaymentMethod;
  orderId: string;
  userId: string;
  status: EStatusPayment;
  addressOrder: string;
}
