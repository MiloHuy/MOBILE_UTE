import { EApiStatus } from "../../constanst/api.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import { ModalAddressOrder } from "../../models/adress-order/addressOrder";
import { IRequestCreateAddressOrder } from "./interface";

const getAddressOrderByUserId = async (userId: string): Promise<any> => {
  if (!userId) return {
    code: ECode.NOT_FOUND,
    message: EMessage.NOT_FIND_USER
  }

  try {
    const orders = await ModalAddressOrder.find({ userId: userId })
    return orders;
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const createAddressOrder = async (data: IRequestCreateAddressOrder['body']): Promise<any> => {
  try {
    const addressOrder = await ModalAddressOrder.create(data)
    return addressOrder;
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

export { createAddressOrder, getAddressOrderByUserId };

