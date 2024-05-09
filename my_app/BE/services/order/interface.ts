import { EOrderStatus } from "../../models/orders/interface"
import { IResponse } from "../interface"

export interface ICreateOrder {
  body: {
    userId: string,
    productId: string,
    productPrice: number,
    productQuanitiOrder: number,
    productSize: string,
    status?: EOrderStatus,
    confirm?: boolean
    addressId?: string
  }
}

export interface IResposeCreateOrder extends IResponse {
  _id?: string,
  userId?: string,
  productId?: string[],
  productPrice?: number[],
  productQuanitiOrder?: number[],
  productSize?: string[],
  addressId?: string,
  status?: EOrderStatus,
  confirm?: boolean
}

export interface IRequestAddToCart {
  body: {
    userId: string,
    productId: string,
    productPrice: number,
    productQuanitiOrder: number,
    productSize: string,
  }
}

export interface IRequestDeleteProductInCart {
  params: {
    orderId: string
  }
  body: {
    productId: string
  }
}

export interface IRequestConfirmOrder {
  body: {
    confirm: boolean
  }
  params: {
    orderId: string
  }
}

export interface IRequestGetAllOrdersByUserId {
  params: {
    userId: string
  }
}

export interface IRequestGetAllOrdersByStatus {
  params: {
    userId: string
  },
  body: {
    status: EOrderStatus
  }
}

export interface IRequestUpdateStatusOrder {
  params: {
    orderId: string
  },
  body: {
    status: EOrderStatus
  }
}

export interface IResposeGetAllProductByUserId extends IResponse {
  allProduct?: [
    {
      productId: string,
      productPrice: number,
      productQuanitiOrder: number,
    }
  ]
}

export interface IRequestUpdateOrderByField {
  body: {
    orderId: string
    userId: string,
    productId: string[],
    productPrice: number[],
    productQuanitiOrder: number[],
    productSize: string,
    addressId: string,
    status: EOrderStatus,
    confirm: boolean
  }
}

export interface IResponseGetOrderById extends IResponse {
  order?: {
    userId: string,
    productId: string[],
    productPrice: number[],
    productQuanitiOrder: number[],
    productSize: string[],
    addressId: string,
    status: EOrderStatus,
    confirm: boolean
  }
}
