class Orders {
  final String userId;
  final String productId;
  final String productName;
  final int productPrice;
  final int productQuanitiOrder;
  final List<String> productSize;
  final String productImg;

  Orders({
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuanitiOrder,
    required this.productSize,
    required this.productImg,
  });

  factory Orders.fromJSON(Map<String, dynamic> json) {
    return Orders(
      userId: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productPrice: json['productPrice'] ?? 0,
      productQuanitiOrder: json['productQuanitiOrder'] ?? 0,
      productSize: (json['productSize'] as List<dynamic>).cast<String>(),
      productImg: json['productImg'] ?? '',
    );
  }
}
