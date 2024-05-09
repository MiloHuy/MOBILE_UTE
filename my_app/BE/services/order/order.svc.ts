import { EApiStatus } from "../../constanst/api.const";
import { EPagingDefaults } from "../../constanst/app.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import { EOrderStatus } from "../../models/orders/interface";
import { ModalOrder } from "../../models/orders/order.model";
import { ICreateOrder, IRequestAddToCart, IRequestUpdateOrderByField, IResponseGetOrderById, IResposeCreateOrder, IResposeGetAllProductByUserId } from "./interface";

const getAllOrders = async (
  page: number = EPagingDefaults.pageIndex,
  limit: number = EPagingDefaults.pageSize): Promise<any> => {

  try {
    const skip = (page - 1) * limit;
    const orders = await ModalOrder.find({})
      .select({ password: 0, __v: 0, updatedAt: 0 })
      .sort([['createdAt', 'desc']])
      .skip(skip)
      .limit(limit);
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

const getOrderById = async (orderId: string): Promise<IResponseGetOrderById | null> => {
  if (!orderId) return {
    code: ECode.NOT_FOUND,
    message: EMessage.NOT_FOUND_PRODUCT
  }

  try {
    return await ModalOrder.findById(orderId)
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const getAllOrderByUserId = async (
  userId: string,
):
  Promise<any> => {

  if (!userId) return {
    code: ECode.NOT_FOUND,
    message: EMessage.NOT_FIND_USER
  }

  try {
    const orders = await ModalOrder.findById({ userId: userId })
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

const getAllOrderByField = async (field: Partial<IRequestUpdateOrderByField['body']>, exceptSelect = {}): Promise<any> => {
  if (!field) return {
    code: ECode.NOT_FOUND,
    message: EMessage.NOT_FOUND_PRODUCT
  }

  try {
    if (field.orderId) return ModalOrder.findById(field.orderId).select(exceptSelect)
    return ModalOrder.find(field).select(exceptSelect)
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const getAllOrderByStatus = async (
  status: EOrderStatus,
  page: number = EPagingDefaults.pageIndex,
  limit: number = EPagingDefaults.pageSize,
  userId: string,
  exceptSelect = {}
): Promise<any> => {

  if (!status) return {
    code: ECode.NOT_FOUND,
    message: EMessage.NOT_FOUND_PRODUCT
  }

  if (!Object.values(EOrderStatus).includes(status)) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    const skip = (page - 1) * limit;
    const orders = await ModalOrder.find({ status: status, userId: userId }, exceptSelect)
      .skip(skip)
      .sort([['createdAt', 'desc']])
      .limit(limit);

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

const getAllProductOrderByUserId = async (userId: string, exceptSelect = {}): Promise<IResposeGetAllProductByUserId> => {
  if (!userId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FIND_USER,
    }
  }

  try {
    const orders = await ModalOrder.find({ userId: userId }, exceptSelect);
    return orders as IResposeGetAllProductByUserId;
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const getOrderByUserIdAndStatus = async (userId: string, status: EOrderStatus): Promise<any> => {
  if (!userId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FIND_USER
    }
  }

  if (!Object.values(EOrderStatus).includes(status)) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    return ModalOrder.find({ userId: userId, status: status })
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const createOrder = async (order: ICreateOrder['body']): Promise<IResposeCreateOrder> => {
  if (!order) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    const newOrder = await ModalOrder.create(order)
    return newOrder.toObject()
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const deleteOrder = async (orderId: string): Promise<any> => {
  if (!orderId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    return await ModalOrder.findByIdAndDelete(orderId)
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const confirmOrder = async (orderId: string, confirm: boolean): Promise<any> => {
  if (!orderId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    return ModalOrder.findByIdAndUpdate(orderId, { $set: { confirm: confirm } }, { new: true })
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const updateStatusOrder = async (orderId: string, status: EOrderStatus): Promise<any> => {
  if (!orderId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  if (!Object.values(EOrderStatus).includes(status)) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    return await ModalOrder.findByIdAndUpdate(orderId, { $set: { status: status } }, { new: true })
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const updateOrderByUserId = async (userId: string, order: IRequestAddToCart['body']): Promise<any> => {
  if (!userId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FIND_USER
    }
  }

  try {
    return await ModalOrder.findOneAndUpdate({ userId: userId }, order, { new: true })
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const updateAddressOrder = async (orderId: string, addressOrder?: string): Promise<any> => {
  if (!orderId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    return await ModalOrder.findByIdAndUpdate(orderId, { $set: { addressOrder: addressOrder } }, { new: true })
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const updateOrderByField = async (
  orderId: string,
  field: Partial<IRequestUpdateOrderByField['body']>): Promise<any> => {
  if (!orderId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }

  try {
    return await ModalOrder.findByIdAndUpdate(orderId, { $set: field }, { new: true })
  }
  catch (err) {
    console.log('err', err)
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}

const removeProductOrder = async (orderId: string, productId: string): Promise<any> => {
  if (!orderId || !productId) {
    return {
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_PRODUCT
    }
  }
  try {
    return ModalOrder.findByIdAndUpdate(orderId, { $pull: { products: { _id: productId } } }, { new: true })
  }
  catch (err) {
    return {
      statusApi: EApiStatus.Error,
      code: ECode.MONGO_SERVER_ERROR,
      message: EMessage.MONGO_SERVER_ERROR
    }
  }
}
export {
  confirmOrder,
  createOrder, deleteOrder, getAllOrderByField, getAllOrderByStatus,
  getAllOrderByUserId, getAllOrders,
  getAllProductOrderByUserId, getOrderById, getOrderByUserIdAndStatus,
  removeProductOrder,
  updateAddressOrder,
  updateOrderByField,
  updateOrderByUserId,
  updateStatusOrder
};

