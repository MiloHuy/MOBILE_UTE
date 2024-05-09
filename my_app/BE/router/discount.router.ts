import express from 'express';
import { handleCreateDiscount, handleGetAllDiscounts } from '../controller/discount/discount.controller';

const routerDiscount = express.Router();

const ROUTER_DISCOUNT_API = {
  GET: {
    all: '/api/discount/all',
  },
  POST: {
    create: '/api/discount/create',
  },
}

routerDiscount.get(ROUTER_DISCOUNT_API.GET.all, handleGetAllDiscounts)

routerDiscount.post(ROUTER_DISCOUNT_API.POST.create, handleCreateDiscount)

export default routerDiscount
