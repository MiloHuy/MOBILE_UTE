class Products {
  final String id;
  final String name;
  final List<Price> prices;
  final String productTypeId;
  final String productTypeName;
  final List<Marker> markers;
  final String description;
  final List<String> images;
  final DateTime createdAt;
  final Price defaultPrice;
  final String defaultImage;

  Products({
    required this.id,
    required this.name,
    required this.prices,
    required this.productTypeId,
    required this.productTypeName,
    required this.markers,
    required this.description,
    required this.images,
    required this.createdAt,
    required this.defaultPrice,
    required this.defaultImage,
  });

  factory Products.fromJSON(Map<String, dynamic> json) {
    return Products(
      id: json['_id'],
      name: json['name'],
      prices: (json['prices'] as List<dynamic>)
          .map((priceJson) => Price.fromJSON(priceJson))
          .toList(),
      productTypeId: json['productType']['_id'],
      productTypeName: json['productType']['name'],
      markers: (json['markers'] as List<dynamic>)
          .map((markerJson) => Marker.fromJSON(markerJson))
          .toList(),
      description: json['desc'],
      images: List<String>.from(json['images'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      defaultPrice: Price.fromJSON(json['defaultPrice']),
      defaultImage: json['defaultImage'],
    );
  }
}

class Price {
  final String size;
  final int price;
  final String id;

  Price({
    required this.size,
    required this.price,
    required this.id,
  });

  factory Price.fromJSON(Map<String, dynamic> json) {
    return Price(
      size: json['size'],
      price: json['price'],
      id: json['_id'],
    );
  }
}

class Marker {
  final String id;
  final String name;

  Marker({
    required this.id,
    required this.name,
  });

  factory Marker.fromJSON(Map<String, dynamic> json) {
    return Marker(
      id: json['_id'],
      name: json['name'],
    );
  }
}
