import { Request, Response } from "express";
import { EApiStatus } from "../../constanst/api.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import catchAsync from "../../middlewares/catchAsyncErrors.mid";
import { getCategoryByName } from "../../services/category/category.svc";
import { createDiscount, getAllDiscounts, getAllDiscountsByField } from "../../services/discounts/discounts.svc";
import { IRequestCreateDiscount, IRequestGetAllDiscountsByField } from "../../services/discounts/interface";
import { isDataObject } from "../utils";

const handleCreateDiscount = catchAsync(
  async (req: Request<any, any, IRequestCreateDiscount, any>, res: Response) => {
    const categoryId = await getCategoryByName(req.body.categoryName);
    if (!isDataObject(categoryId)) {
      return res.status(ECode.FAIL).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FOUND_CATEGORY
      });
    }

    console.log('categoryId:', categoryId);

    const discount = await createDiscount({
      categoryId: categoryId._id,
      code: req.body.code,
      nameDiscount: req.body.nameDiscount,
      minValue: req.body.minValue,
      maxValue: req.body.maxValue
    });

    if (discount.code && discount.code === ECode.NOT_FOUND) {
      return res.status(ECode.FAIL).json({
        message: discount.message
      });
    }

    if (discount.status && discount.status === EApiStatus.Error) {
      return res.status(ECode.FAIL).json({
        message: discount.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.CREATE_DISCOUNT_SUCCESS,
      data: discount
    })
  }
)

const handleGetAllDiscounts = catchAsync(
  async (req: Request, res: Response) => {
    const discounts = await getAllDiscounts();
    if (discounts.code && discounts.code === ECode.NOT_FOUND) {
      return res.status(ECode.FAIL).json({
        message: discounts.message
      });
    }

    if (discounts.status && discounts.status === EApiStatus.Error) {
      return res.status(ECode.FAIL).json({
        message: discounts.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.GET_ALL_DISCOUNTS_SUCCESS,
      data: discounts
    });
  }
)

const handleGetDiscountByField = catchAsync(
  async (req: Request<any, any, IRequestGetAllDiscountsByField['field'], any>, res: Response) => {
    const discounts = await getAllDiscountsByField(req.body);
    if (discounts.code && discounts.code === ECode.NOT_FOUND) {
      return res.status(ECode.FAIL).json({
        message: discounts.message
      });
    }

    if (discounts.status && discounts.status === EApiStatus.Error) {
      return res.status(ECode.FAIL).json({
        message: discounts.message
      });
    }

    return res.status(ECode.SUCCESS).json({
      status: ECode.SUCCESS,
      message: EMessage.GET_ALL_DISCOUNTS_SUCCESS,
      data: discounts
    });
  })

export {
  handleCreateDiscount,
  handleGetAllDiscounts,
  handleGetDiscountByField
};

