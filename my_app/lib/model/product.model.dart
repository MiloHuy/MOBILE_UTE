class Products {
  final String id;
  final String productName;
  final List<int> price;
  final List<String> size;
  final String brandId;
  final String description;
  final String productImg;
  final bool isLiked;

  Products({
    required this.id,
    required this.productName,
    required this.price,
    required this.size,
    required this.brandId,
    required this.description,
    required this.productImg,
    required this.isLiked,
  });

  factory Products.fromJSON(Map<String, dynamic> json) {
    return Products(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      productImg: json['productImg'] ?? '',
      price: (json['price'] as List<dynamic>).cast<int>(),
      size: (json['size'] as List<dynamic>).cast<String>(),
      brandId: json['brand_id'] ?? '',
      description: json['description'] ?? '',
      isLiked: json['isLiked'] ?? false,
    );
  }
}
