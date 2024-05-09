import { Request, Response } from "express";
import { EApiStatus } from "../../constanst/api.const";
import { ECode, EMessage } from "../../constanst/code-mess.const";
import catchAsync from "../../middlewares/catchAsyncErrors.mid";
import { createAddressOrder, getAddressOrderByUserId } from "../../services/address-order/addressOrder.svc";
import { IRequestCreateAddressOrder, IRequseGetAllAddressOrderByUserId } from "../../services/address-order/interface";

const handleCreateAddressOrder = catchAsync(
  async (req: Request<any, any, IRequestCreateAddressOrder['body']>, res: Response) => {
    const newAddressOrder = await createAddressOrder(req.body);

    if (newAddressOrder.statusApi && newAddressOrder.statusApi === EApiStatus.Error) {
      return res.status(ECode.FAIL).json({
        code: ECode.MONGO_SERVER_ERROR,
        message: EMessage.MONGO_SERVER_ERROR
      });
    }

    res.status(ECode.SUCCESS).json({
      code: ECode.SUCCESS,
      message: EMessage.ADD_ADDRESS_ORDER_SUCCESS,
      data: newAddressOrder
    });
  }
)

const handleGetAllAddressOrderByUserId = catchAsync(
  async (req: Request<IRequseGetAllAddressOrderByUserId['params']>, res: Response) => {
    const { userId } = req.params;

    const addressOrders = await getAddressOrderByUserId(userId);

    if (!addressOrders) {
      return res.status(ECode.NOT_FOUND).json({
        code: ECode.NOT_FOUND,
        message: EMessage.NOT_FIND_USER
      });
    }

    res.status(ECode.SUCCESS).json({
      code: ECode.SUCCESS,
      message: EMessage.GET_ADDRESS_ORDER_SUCCESS,
      data: addressOrders
    });
  }
)

export { handleCreateAddressOrder, handleGetAllAddressOrderByUserId };

