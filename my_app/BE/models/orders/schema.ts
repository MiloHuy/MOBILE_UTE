import { Schema } from "mongoose";
import { nameModelAddressOrders } from "../adress-order/addressOrder";
import { nameModelBrands } from "../brand/brand.modal";
import { nameModelProduct } from "../product/product.modal";
import { nameModelUser } from "../user/user.modal";
import { EOrderStatus, IOrderSchema } from "./interface";

export const orderSchema: Schema<IOrderSchema> = new Schema({
  userId: {
    type: String,
    ref: nameModelUser,
    required: true
  },
  brandId: {
    type: [String],
    ref: nameModelBrands,
    required: true
  },
  productId: {
    type: [String],
    ref: nameModelProduct,
    required: true
  },
  productPrice: {
    type: [Number],
    required: true
  },
  productQuanitiOrder: {
    type: [Number],
    required: true
  },
  productSize: {
    type: [String],
    required: true
  },
  addressId: {
    type: String,
    ref: nameModelAddressOrders,
  },
  status: {
    type: String,
    enum: EOrderStatus,
    default: EOrderStatus.NOT_ORDER
  },
  confirm: {
    type: Boolean,
    default: false
  }
}, {
  timestamps: true
})
