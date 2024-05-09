import express from "express";
// validateRequestMiddleware('body', statusOrderedSchema),
import { handleCreatePaymentForProduct, handleCreatePaymentInCart } from "../controller/payments/payment.controller";
import { schemaCreatePaymentForProduct } from "../controller/payments/payment.validation";
import validateRequestMiddleware from "../middlewares/validate-request.mid";

const routerPayment = express.Router();

const ROUTER_PAYMENT_API = {
  POST: {
    paymentInCart: '/api/payment/paymentInCart',
    paymentProduct: '/api/payment/paymentProduct',
  },
}

routerPayment.post(
  ROUTER_PAYMENT_API.POST.paymentInCart,
  handleCreatePaymentInCart
);

routerPayment.post(
  ROUTER_PAYMENT_API.POST.paymentProduct,
  validateRequestMiddleware('body', schemaCreatePaymentForProduct),
  handleCreatePaymentForProduct
);

export default routerPayment
