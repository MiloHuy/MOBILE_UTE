import { EApiStatus } from "../../constanst/api.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import { ModalDiscount } from "../../models/discount/discount.model";
import { IRequestGetAllDiscountsByField } from "./interface";

const createDiscount = async (discount: any): Promise<any> => {
  try {
    const newDiscount = await ModalDiscount.create(discount);
    return newDiscount;
  } catch (error) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const getAllDiscountsByField = async (
  field: IRequestGetAllDiscountsByField['field'],
  exceptSelect = { __v: 0, updatedAt: 0 }
): Promise<any> => {
  try {
    const discounts = await ModalDiscount.find(field).select(exceptSelect);
    return discounts;
  } catch (error) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const getAllDiscounts = async (): Promise<any> => {
  try {
    const discounts = await ModalDiscount.find({});
    return discounts;
  } catch (error) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

export { createDiscount, getAllDiscounts, getAllDiscountsByField };

