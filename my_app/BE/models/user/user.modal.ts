import { Document, model } from "mongoose";
import { IUserSchema } from "./interface";
import { userSchema } from "./shema";

export const nameModelUser = 'users';
export const ModalUser = model<IUserSchema & Document>(nameModelUser, userSchema);
