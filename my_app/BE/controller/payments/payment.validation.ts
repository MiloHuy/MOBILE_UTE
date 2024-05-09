import { number, object, ObjectSchema, string } from "yup";
import { IRequestCreatePaymentForProduct } from "../../services/payments/interface";
import { genMessRequired } from "../utils";

export const schemaCreatePaymentForProduct: ObjectSchema<Record<keyof IRequestCreatePaymentForProduct['body'], unknown>> = object().shape({
  userId: string().required(genMessRequired('userId')),
  productId: string().required(genMessRequired('productId')),
  receiverName: string().required(genMessRequired('receiverName')),
  phone: number().required(genMessRequired('Số điện thoại')).typeError('phone must be a number'),
  brandId: string().required(genMessRequired('brandId')),
  productPrice: number().required(genMessRequired('productPrice')),
  productQuanitiOrder: number().required(genMessRequired('productQuanitiOrder')),
  productSize: string().required(genMessRequired('productSize')),
  addressOrder: string().required(genMessRequired('addressOrder')),
})
