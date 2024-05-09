export enum ENameDiscount {
  SYS = 'SYS',
  USER = 'USER',
  BRAND = 'BRAND',
  CATEGORY = 'CATEGORY',
  PRODUCT = 'PRODUCT',
}

export interface ICreateDiscount {
  categoryId: string
  code: string
  nameDiscount?: string
  minValue: number
  maxValue: number
}

export interface IRequestGetAllDiscountsByField {
  field: {
    categoryId?: string
    code?: string
    nameDiscount?: string
    minValue?: number
    maxValue?: number
    userId?: string
    brandId?: string
  }
}

export interface IRequestCreateDiscount {
  categoryName: string
  code: string
  nameDiscount?: string
  minValue: number
  maxValue: number
}
