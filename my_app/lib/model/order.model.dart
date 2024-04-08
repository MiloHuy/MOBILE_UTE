class Orders {
  final String userId;
  final String productId;
  final String productName;
  final int productPrice;
  final int productQuantityOrder;
  final String productSize;
  final String productImg;

  Orders({
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantityOrder,
    required this.productSize,
    required this.productImg,
  });

  factory Orders.fromJSON(Map<String, dynamic> json) {
    return Orders(
      userId: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productPrice: json['productPrice'] ?? 0,
      productQuantityOrder: json['productQuantityOrder'] ?? 0,
      productSize: json['productSize'] ?? '',
      productImg: json['productImg'] ?? '',
    );
  }

  Object? toJSON() {
    return null;
  }
}
