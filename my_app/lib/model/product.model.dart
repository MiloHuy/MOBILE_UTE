class Products {
  final String id;
  final String productName;
  final int price;
  final String description;
  final String productImg;
  final DateTime createdAt;

  @override
  String toString() {
    return 'Products{id: $id, productName: $productName, price: $price, description: $description, productImg: $productImg, createdAt: $createdAt}';
  }

  Products({
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.productImg,
    required this.createdAt,
  });

  factory Products.fromJSON(Map<String, dynamic> json) {
    return Products(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      productImg: json['productImg'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }
}
