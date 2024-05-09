import { EApiStatus } from "../constanst/api.const";
import { ECode } from "../constanst/code-mess.const";

export interface IResponse {
  code?: ECode;
  message?: string;
  statusApi?: EApiStatus;
}
