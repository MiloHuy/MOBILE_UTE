export interface IRequestCreateAddressOrder {
  body: {
    userId: string;
    receiverName: string;
    phone: number;
    addressOrder: string;
  }
}

export interface IRequseGetAllAddressOrderByUserId {
  params: {
    userId: string;
  }
}
