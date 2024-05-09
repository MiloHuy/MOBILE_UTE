class ProductAddToCart {
  final String id;
  final String productName;
  final List<int> price;
  final List<String> size;
  final String brandId;
  final String description;
  final String productImg;
  final bool isLiked;

  @override
  String toString() {
    return 'ProductAddToCart: {id: $id, productName: $productName, price: $price, size: $size, brandId: $brandId, description: $description, productImg: $productImg, isLiked: $isLiked}';
  }

  ProductAddToCart({
    required this.id,
    required this.productName,
    required this.price,
    required this.size,
    required this.brandId,
    required this.description,
    required this.productImg,
    required this.isLiked,
  });

  factory ProductAddToCart.fromJSON(Map<String, dynamic> json) {
    return ProductAddToCart(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      productImg: json['productImg'] ?? '',
      brandId: json['brand_id'] ?? '',
      price: (json['price'] as List<dynamic>).cast<int>(),
      size: (json['size'] as List<dynamic>).cast<String>(),
      description: json['description'] ?? '',
      isLiked: json['isLiked'] ?? false,
    );
  }
}

class ProductAddToCartRes {
  final int status;
  final String message;
  final String id;
  final List<ProductAddToCart> products;
  final List<int> productPrice;
  final List<int> productQuanitiOrder;
  final List<String> productSize;
  final String statusOrder;
  final bool confirm;

  ProductAddToCartRes({
    required this.status,
    required this.message,
    required this.id,
    required this.products,
    required this.productPrice,
    required this.productQuanitiOrder,
    required this.productSize,
    required this.statusOrder,
    required this.confirm,
  });

  factory ProductAddToCartRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List && json['data'].isEmpty) {
      return ProductAddToCartRes(
        status: json['status'],
        message: json['message'],
        id: '',
        products: [],
        productPrice: [],
        productQuanitiOrder: [],
        productSize: [],
        statusOrder: '',
        confirm: false,
      );
    }

    List<dynamic> productsData = json['data']['products'];

    List<ProductAddToCart> products = productsData
        .map<ProductAddToCart>((json) => ProductAddToCart.fromJSON(json))
        .toList();

    return ProductAddToCartRes(
      status: json['status'],
      message: json['message'],
      id: json['data']['id'],
      products: products,
      productPrice: List<int>.from(json['data']['productPrice']),
      productQuanitiOrder: List<int>.from(json['data']['productQuanitiOrder']),
      productSize: List<String>.from(json['data']['productSize']),
      statusOrder: json['data']['status'],
      confirm: json['data']['confirm'],
    );
  }
}
