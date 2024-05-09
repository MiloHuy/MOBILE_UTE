import { Schema } from "mongoose";
import { IAddressOrderSchema } from "./interface";

export const addressOrderSchema: Schema<IAddressOrderSchema> = new Schema({
  userId: { type: String, required: true },
  receiverName: { type: String, required: true },
  phone: { type: Number, required: true },
  addressOrder: { type: String, required: true },
})
