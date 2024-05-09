import express from "express";
import { handleAddToCart, handleConfirmOrder, handleDeleteProductInCart, handleGetAllOrdersByStatus, handleGetAllOrdersByUserId, handleUpdateOrderByStatus } from "../controller/order/order.controller";
import { addToCartSchema } from "../controller/order/order.validation";
import { userIdSchema } from "../controller/user/user.validation";
import validateRequestMiddleware from "../middlewares/validate-request.mid";

const routerOrder = express.Router();

const ROUTER_ORDER_API = {
  GET: {
    allProductAddToCart: '/api/product/allProductAddToCart/:userId',
  },
  POST: {
    allOrderStatus: '/api/product/allOrderStatus/:userId',
    addToCart: '/api/product/addToCart',
    confirmOrder: '/api/product/confirmOrder/:orderId',
    updateOrder: '/api/product/updateOrder/:orderId',
  },
  DELETE: {
    deleteProductInCart: '/api/product/deleteProductInCart/:orderId'
  }
}

routerOrder.get(
  ROUTER_ORDER_API.GET.allProductAddToCart,
  validateRequestMiddleware('params', userIdSchema),
  handleGetAllOrdersByUserId
);

routerOrder.post(
  ROUTER_ORDER_API.POST.allOrderStatus,
  validateRequestMiddleware('params', userIdSchema),
  handleGetAllOrdersByStatus);

routerOrder.post(
  ROUTER_ORDER_API.POST.addToCart,
  validateRequestMiddleware('body', addToCartSchema),
  handleAddToCart
);

routerOrder.post(
  ROUTER_ORDER_API.POST.confirmOrder,
  handleConfirmOrder
);

routerOrder.post(
  ROUTER_ORDER_API.POST.updateOrder,
  handleUpdateOrderByStatus
);

routerOrder.delete(
  ROUTER_ORDER_API.DELETE.deleteProductInCart,
  handleDeleteProductInCart
);

export default routerOrder