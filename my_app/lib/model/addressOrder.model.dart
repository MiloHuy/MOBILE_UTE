class AddressOrder {
  final String userId;
  final String receiverName;
  final int phone;
  final String addressOrder;

  AddressOrder({
    required this.userId,
    required this.receiverName,
    required this.phone,
    required this.addressOrder,
  });

  factory AddressOrder.fromJson(Map<String, dynamic> json) {
    return AddressOrder(
      userId: json['userId'] ?? '',
      receiverName: json['receiverName'] ?? '',
      phone: json['phone'] ?? 0,
      addressOrder: json['addressOrder'] ?? '',
    );
  }

  factory AddressOrder.fromJSON(Map<String, dynamic> json) {
    return AddressOrder(
      userId: json['userId'] ?? '',
      receiverName: json['receiverName'] ?? '',
      phone: json['phone'] ?? 0,
      addressOrder: json['addressOrder'] ?? '',
    );
  }
}
