import { NextFunction, Request, Response } from "express";
import { ObjectSchema } from "yup";
import { EMessage } from "../constanst/code-mess.const";

type IContainer = 'body' | 'params' | 'query' | 'headers' | 'files';

const validateRequestMiddleware = (container: IContainer, schema: ObjectSchema<any, any>) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    console.log('req[container]', req[container])
    try {
      if (Object.keys(req[container]).length === 0) {
        return res.status(400).json({
          code: 400,
          message: EMessage.BAD_REQUEST
        })
      }
      await schema.validate(req[container], { abortEarly: false });
      return next();
    }
    catch (err: any) {
      const { errors } = err;

      return res.status(404).json({
        code: 404,
        message: [
          ...errors
        ],
      })
    }
  };
};

export default validateRequestMiddleware
