import { Request, Response } from "express";
import { EApiStatus } from "../../constanst/api.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import catchAsync from "../../middlewares/catchAsyncErrors.mid";
import { EOrderStatus } from "../../models/orders/interface";
import { EPaymentMethod, EStatusPayment } from "../../models/payments/interface";
import { createAddressOrder, getAddressOrderByUserId } from "../../services/address-order/addressOrder.svc";
import { createOrder, deleteOrder, getOrderById } from "../../services/order/order.svc";
import { IRequestCreatePayment, IRequestCreatePaymentForProduct } from "../../services/payments/interface";
import { createPayment } from "../../services/payments/payments.svc";
import { getProductById } from "../../services/product/product.svc";
import { checkDataFromDb, isDataObject } from "../utils";

const handleCreatePaymentInCart = catchAsync(
  async (req: Request<any, any, IRequestCreatePayment['body'], any>, res: Response) => {
    const { addressOrder, orderId, userId } = req.body;

    const data = await getOrderById(orderId);
    const order = data?.order;

    if (!isDataObject(order)) {
      return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_ORDER
      });
    }
    const checkOrder = await checkDataFromDb(order, EMessage.NOT_FOUND_ORDER, res)
    if (!checkOrder) return res.status(ECode.FAIL).json({
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_ORDER
    });

    if (order.userId !== userId && order.status !== EOrderStatus.NOT_ORDER) {
      return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_ORDER
      });
    }

    const allProductOrder = order.productId

    allProductOrder.forEach(async (product, index) => {
      const data = await getProductById(product);
      const productOrder = data?.product;

      if (!isDataObject(productOrder)) {
        return res.status(ECode.FAIL).json({
          code: ECode.NOT_FOUND,
          message: EMessage.NOT_FOUND_PRODUCT
        });
      }
      const checkProduct = await checkDataFromDb(productOrder, EMessage.NOT_FOUND_PRODUCT, res)
      if (!checkProduct) return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_PRODUCT
      });

      const newOrder = await createOrder({
        userId,
        productId: productOrder._id,
        productPrice: productOrder.price[0],
        productQuanitiOrder: order.productQuanitiOrder[index],
        productSize: order.productSize[index][0],
        status: EOrderStatus.ORDERED,
        confirm: false
      });

      if (!isDataObject(newOrder)) {
        return res.status(ECode.FAIL).json({
          code: ECode.NOT_FOUND,
          message: EMessage.NOT_FOUND_ORDER
        });
      }

      const checkNewOrder = await checkDataFromDb(newOrder, EMessage.NOT_FOUND_ORDER, res)
      if (!checkNewOrder) return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_ORDER
      });

      const payment = await createPayment({
        method: EPaymentMethod.COD,
        orderId: newOrder._id as string,
        status: EStatusPayment.NOT_PAYMENT,
        userId
      });

      if (!isDataObject(payment)) {
        return res.status(ECode.FAIL).json({
          code: ECode.NOT_FOUND,
          message: EMessage.NOT_FOUND_PAYMENT
        });
      }

      const checkPayment = await checkDataFromDb(payment, EMessage.NOT_FOUND_PAYMENT, res)
      if (!checkPayment) return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_PAYMENT
      });
    })

    await deleteOrder(orderId);

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.CREATE_PAYMENT_SUCCESS,
    });
  });

const handleCreatePaymentForProduct = catchAsync(
  async (req: Request<any, any, IRequestCreatePaymentForProduct['body'], any>, res: Response) => {
    const { userId, productId, productPrice, productQuanitiOrder, productSize, addressOrder, receiverName, phone } = req.body;

    let addressUser = await getAddressOrderByUserId(userId);

    if (!addressUser || addressUser.status === EApiStatus.Error) {
      const createAddress = await createAddressOrder({ userId, addressOrder, receiverName, phone });

      if (createAddress.code && createAddress.code === ECode.FAIL || createAddress.status === EApiStatus.Error) {
        return res.status(createAddress.code || 500).json({
          code: createAddress.code || 500,
          message: createAddress.message || "Failed to create address"
        });
      }

      addressUser = createAddress; // Update addressUser with the newly created address
    }

    const newOrder = await createOrder({
      userId,
      productId,
      productPrice,
      productQuanitiOrder,
      productSize,
      addressId: addressUser._id,
      status: EOrderStatus.ORDERED,
      confirm: false
    });

    if (!isDataObject(newOrder)) {
      return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_ORDER
      });
    }

    const payment = await createPayment({
      method: EPaymentMethod.COD,
      orderId: newOrder._id as string,
      status: EStatusPayment.NOT_PAYMENT,
      userId
    });

    if (!isDataObject(payment)) {
      return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_PAYMENT
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.CREATE_PAYMENT_SUCCESS,
    });
  });


export {
  handleCreatePaymentForProduct, handleCreatePaymentInCart
};

