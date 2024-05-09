import express from "express";
import { handleCreateAddressOrder, handleGetAllAddressOrderByUserId } from "../controller/address-order/addressOrder.validation";
import { userIdSchema } from "../controller/user/user.validation";
import validateRequestMiddleware from "../middlewares/validate-request.mid";

const routerAddressOrder = express.Router();

const ROUTER_ADDRESS_ORDER_API = {
  GET: {
    addressOrders: '/api/addressOrders/:userId',
  },
  POST: {
    newAddressOrder: '/api/addressOrder/new',
  },
}

routerAddressOrder.get(
  ROUTER_ADDRESS_ORDER_API.GET.addressOrders,
  validateRequestMiddleware('params', userIdSchema),
  handleGetAllAddressOrderByUserId
)

routerAddressOrder.post(
  ROUTER_ADDRESS_ORDER_API.POST.newAddressOrder,
  handleCreateAddressOrder
);

export default routerAddressOrder
