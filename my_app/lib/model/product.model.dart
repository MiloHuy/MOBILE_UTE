import 'package:flutter/material.dart';

class Products {
  int? productId;
  String? name;
  List? prices;
  Object? productType;
  List? markers;
  String? desc;
  List? images;
  TimeOfDay? createdAt;
  Object? defaultPrice;
  String? defaultImage;

  Products(
      {required this.productId,
      required this.name,
      this.prices,
      this.createdAt,
      this.productType,
      this.defaultImage,
      this.desc,
      this.images,
      this.defaultPrice,
      this.markers});

  Products.fromJSON(Map<String, dynamic> json) {
    productId = json["_id"];
    name = json["name"];
    prices = json["prices"]?.cast<int>();
    productType = json["productType"];
    markers = json["markers"]?.cast<int>();
    desc = json["desc"];
    images = json["images"]?.cast<String>();
    createdAt = json["createdAt"] != null
        ? TimeOfDay.fromDateTime(DateTime.parse(json["createdAt"]))
        : null;
    defaultPrice = json["defaultPrice"];
    defaultImage = json["defaultImage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = productId;
    data['name'] = name;
    data['prices'] = prices;
    data['createdAt'] = createdAt;
    data['productType'] = productType;
    data['defaultImage'] = defaultImage;
    data['desc'] = desc;
    data['images'] = images;
    data['defaultPrice'] = defaultPrice;
    data['markers'] = markers;

    return data;
  }
}
