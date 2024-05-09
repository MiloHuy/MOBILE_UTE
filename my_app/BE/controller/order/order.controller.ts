import { Request, Response } from "express";
import { EApiStatus } from "../../constanst/api.const";
import { EArrayIndex, EPagingDefaults } from "../../constanst/app.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import catchAsync from "../../middlewares/catchAsyncErrors.mid";
import { EOrderStatus } from "../../models/orders/interface";
import { IRequestAddToCart, IRequestConfirmOrder, IRequestDeleteProductInCart, IRequestGetAllOrdersByStatus, IRequestGetAllOrdersByUserId, IRequestUpdateStatusOrder } from "../../services/order/interface";
import { confirmOrder, createOrder, deleteOrder, getAllOrderByField, getAllOrderByStatus, getAllOrderByUserId, getAllOrders, updateOrderByField, updateStatusOrder } from "../../services/order/order.svc";
import { getProductById } from "../../services/product/product.svc";
import { checkDataFromDb, isDataObject } from "../utils";

const handleGetOrderByUserId = catchAsync(
  async (req: Request, res: Response) => {
    const orders = await getAllOrderByUserId(req.params.userId);

    if (orders.code && orders.code === ECode.NOT_FOUND) {
      return res.status(orders.code).json({
        message: orders.message
      });
    }

    if (orders.status && orders.status === EApiStatus.Error) {
      return res.status(orders.code).json({
        message: orders.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: 'Get order by user id successfully',
      data: orders
    })
  }
)

const handleGetAllOrders = catchAsync(
  async (req: Request, res: Response) => {
    const orders = await getAllOrders();

    if (orders.code && orders.code === ECode.NOT_FOUND) {
      return res.status(orders.code).json({
        message: orders.message
      });
    }

    if (orders.status && orders.status === EApiStatus.Error) {
      return res.status(orders.code).json({
        message: orders.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: 'Get all orders successfully',
      data: orders
    })
  }
)

const handleGetAllOrdersByUserId = catchAsync(
  async (req: Request<IRequestGetAllOrdersByUserId['params'], any, any>, res: Response) => {
    const orders = await getAllOrderByUserId(req.params.userId);

    if (orders.code && orders.code === ECode.NOT_FOUND) {
      return res.status(ECode.FAIL).json({
        code: ECode.FAIL,
        message: orders.message
      });
    }

    if (orders.status && orders.status === EApiStatus.Error) {
      return res.status(orders.code).json({
        message: orders.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.GET_PRODUCT_SUCCESS,
      data: orders
    })
  }
)

const handleConfirmOrder = catchAsync(
  async (req: Request<IRequestConfirmOrder['params'], any, any, IRequestConfirmOrder['body'], any>, res: Response) => {
    const order = await confirmOrder(req.params.orderId, req.body.confirm);

    if (order.code && order.code === ECode.NOT_FOUND) {
      return res.status(order.code).json({
        message: order.message
      });
    }

    if (order.status && order.status === EApiStatus.Error) {
      return res.status(order.code).json({
        message: order.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.CONFIRM_ORDER_SUCCESSFULLY,
      data: order
    })
  }
)

const handleGetAllOrdersByStatus = catchAsync(
  async (req: Request<IRequestGetAllOrdersByStatus['params'], IRequestGetAllOrdersByStatus['body'], any>, res: Response) => {
    console.log('req.params: ', req.params)

    const page = Number(req.query.page) || EPagingDefaults.pageIndex;
    const limit = Number(req.query.limit) || EPagingDefaults.pageSize;

    const orders = await getAllOrderByStatus(req.body.status, page, limit, req.params.userId);

    if (orders.code && orders.code === ECode.NOT_FOUND) {
      return res.status(ECode.FAIL).json({
        code: ECode.FAIL,
        message: EMessage.NOT_FOUND_ORDER
      });
    }

    if (orders.length === 0) {
      return res.status(ECode.SUCCESS).json({
        status: ECode.SUCCESS,
        message: EMessage.NOT_FOUND_ORDER,
        data: []
      });
    }

    if (orders.status && orders.status === EApiStatus.Error) {
      return res.status(ECode.FAIL).json({
        code: ECode.FAIL,
        message: orders.message
      });
    }

    let allProducts: any = []
    allProducts = await Promise.all(orders.map(async (order: any) => {
      const { productId } = order;
      const products = await Promise.all(productId.map(async (id: string) => {
        const product = await getProductById(id);

        if (!isDataObject(product) ||
          product.code && product.code === ECode.NOT_FOUND ||
          product.status && product.status === EApiStatus.Error
        ) {
          return res.status(ECode.FAIL).json({
            code: ECode.NOT_FOUND,
            message: EMessage.NOT_FOUND_PRODUCT
          });
        }

        return product;
      }));
      return products;
    }));

    // Flatten the array
    allProducts = allProducts.flat();

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.GET_PRODUCT_SUCCESS,
      data: {
        id: orders[0]._id,
        products: allProducts,
        productPrice: orders[0].productPrice,
        productQuanitiOrder: orders[0].productQuanitiOrder,
        productSize: orders[0].productSize,
        addressOrder: orders[0].addressOrder,
        status: orders[0].status,
        confirm: orders[0].confirm,
      }
    })
  }
)

const handleAddToCart = catchAsync(
  async (req: Request<any, any, IRequestAddToCart['body'], any>, res: Response) => {

    const { productId, userId, productPrice, productQuanitiOrder } = req.body;

    const allProduct = await getAllOrderByStatus(
      EOrderStatus.NOT_ORDER,
      EPagingDefaults.pageIndex,
      EPagingDefaults.pageSize,
      userId,
      { productId: 1, productPrice: 1, productQuanitiOrder: 1, status: 1 },);

    if (allProduct.statusApi && allProduct.statusApi === EApiStatus.Error) {
      return res.status(ECode.MONGO_SERVER_ERROR).json({
        code: ECode.MONGO_SERVER_ERROR,
        message: allProduct.message
      });
    }

    console.log('allProduct: ', allProduct)

    if (Array.isArray(allProduct) && allProduct.length === 0) {
      const order = await createOrder({
        userId,
        productId,
        productPrice,
        productQuanitiOrder,
        productSize: req.body.productSize,
        status: EOrderStatus.NOT_ORDER
      });

      if (!isDataObject(order)) {
        return res.status(ECode.FAIL).json({
          code: ECode.NOT_FOUND,
          message: EMessage.NOT_FOUND_ORDER
        });
      }

      if (order.code && order.code === ECode.NOT_FOUND) {
        return res.status(order.code).json({
          code: ECode.NOT_FOUND,
          message: order.message
        });
      }

      if (order.status && order.status === EApiStatus.Error) {
        return res.status(ECode.FAIL).json({
          code: ECode.MONGO_SERVER_ERROR,
          message: order.message
        });
      }

      return res.status(ECode.SUCCESS).json({
        status: ECode.SUCCESS,
        message: EMessage.ADD_TO_CART_SUCCESSFULLY,
        data: order
      })
    }

    const { productId: allProductId, productPrice: allProductPrice, productQuanitiOrder: allProductQuanitiOrder } = allProduct[0];
    const productIndex = allProductId.findIndex((id: string) => id.toString() === productId.toString());

    if (productIndex === EArrayIndex.NOT_FOUND) {
      allProductId.push(productId);
      allProductPrice.push(productPrice);
      allProductQuanitiOrder.push(productQuanitiOrder);
    }

    allProductPrice[productIndex] += productPrice;
    allProductQuanitiOrder[productIndex] += productQuanitiOrder;

    const order = await updateOrderByField(allProduct[0]._id, {
      productId: allProductId,
      userId,
      productPrice: allProductPrice,
      productQuanitiOrder: allProductQuanitiOrder,
      productSize: req.body.productSize,
    });

    if (order.code && order.code === ECode.NOT_FOUND) {
      return res.status(order.code).json({
        message: order.message
      });
    }

    if (order.status && order.status === EApiStatus.Error) {
      return res.status(order.code).json({
        message: order.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.ADD_TO_CART_SUCCESSFULLY,
      data: order
    })
  }
)

const handleDeleteProductInCart = catchAsync(
  async (req: Request<IRequestDeleteProductInCart['params'], any, IRequestDeleteProductInCart['body'], any>, res: Response) => {
    const allProduct = await getAllOrderByField(
      { orderId: req.params.orderId },
      { productId: 1, productPrice: 1, productQuanitiOrder: 1, status: 1 }
    );

    if (allProduct.statusApi && allProduct.statusApi === EApiStatus.Error) {
      return res.status(ECode.MONGO_SERVER_ERROR).json({
        code: ECode.MONGO_SERVER_ERROR,
        message: allProduct.message
      });
    }

    if (allProduct.status !== EOrderStatus.NOT_ORDER) {
      return res.status(ECode.BAD_REQUEST).json({
        code: ECode.BAD_REQUEST,
        message: EMessage.NOT_FOUND_ORDER
      });
    }

    if (allProduct.productId.length === 1) {
      const res = await deleteOrder(req.params.orderId);

      if (res.code && res.code === ECode.NOT_FOUND) {
        return res.status(ECode.FAIL).json({
          code: ECode.NOT_FOUND,
          message: res.message
        });
      }

      if (res.statusApi && res.statusApi === EApiStatus.Error) {
        return res.status(ECode.FAIL).json({
          code: ECode.MONGO_SERVER_ERROR,
          message: res.message
        });
      }

      return res.status(ECode.SUCCESS).json({
        status: ECode.SUCCESS,
        message: EMessage.DELETE_PRODUCT_IN_CART_SUCCESSFULLY,
      })
    }

    const isProductExist = allProduct.productId.findIndex((id: string) => id === req.body.productId);
    if (isProductExist === EArrayIndex.NOT_FOUND) {
      return res.status(ECode.BAD_REQUEST).json({
        code: ECode.BAD_REQUEST,
        message: EMessage.NOT_FOUND_PRODUCT
      });
    }

    const updateOrder = await updateOrderByField(
      req.params.orderId,
      {
        productId: allProduct.productId.splice(isProductExist, 1),
        productPrice: allProduct.productPrice.splice(isProductExist, 1),
        productQuanitiOrder: allProduct.productQuanitiOrder.splice(isProductExist, 1),
      })

    const checkUpdateOrder = await checkDataFromDb(updateOrder, EMessage.NOT_FOUND_ORDER, res);
    if (!checkUpdateOrder) return res.status(ECode.FAIL).json({
      code: ECode.NOT_FOUND,
      message: EMessage.NOT_FOUND_ORDER
    });

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.DELETE_PRODUCT_IN_CART_SUCCESSFULLY,
    })
  }
)


const handleUpdateOrderByStatus = catchAsync(
  async (req: Request<IRequestUpdateStatusOrder['params'], IRequestUpdateStatusOrder['body'], any>, res: Response) => {
    console.log('req.params: ', req.params)
    const orders = await updateStatusOrder(req.params.orderId, req.body.status);
    console.log('orders: ', orders)

    if (orders.code && orders.code === ECode.NOT_FOUND) {
      return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: orders.message
      });
    }

    if (orders.status && orders.status === EApiStatus.Error) {
      return res.status(orders.code).json({
        message: orders.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.UPDATE_STATUS_ORDER_SUCCESSFULLY,
    })
  }
)

export {
  handleAddToCart,
  handleConfirmOrder, handleDeleteProductInCart, handleGetAllOrders,
  handleGetAllOrdersByStatus,
  handleGetAllOrdersByUserId,
  handleGetOrderByUserId,
  handleUpdateOrderByStatus
};

