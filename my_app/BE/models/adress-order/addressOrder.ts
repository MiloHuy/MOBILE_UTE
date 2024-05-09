import { model } from "mongoose";
import { addressOrderSchema } from "./schema";

export const nameModelAddressOrders = 'addressOrders';
export const ModalAddressOrder = model(nameModelAddressOrders, addressOrderSchema);
