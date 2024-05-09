class DiscountData {
  final String id;
  final String categoryId;
  final String code;
  final String nameDiscount;
  final int minValue;
  final int maxValue;
  final bool condition;

  @override
  String toString() {
    return 'DiscountData: {id: $id, categoryId: $categoryId, code: $code, nameDiscount: $nameDiscount, minValue: $minValue, maxValue: $maxValue, condition: $condition}';
  }

  DiscountData({
    required this.id,
    required this.categoryId,
    required this.code,
    required this.nameDiscount,
    required this.minValue,
    required this.maxValue,
    required this.condition,
  });

  factory DiscountData.fromJSON(Map<String, dynamic> json) {
    return DiscountData(
      id: json['_id'] ?? '',
      categoryId: json['category_id'] ?? '',
      code: json['code'] ?? '',
      nameDiscount: json['nameDiscount'] ?? '',
      minValue: json['minValue'] ?? 0,
      maxValue: json['maxValue'] ?? 0,
      condition: json['condition'] ?? false,
    );
  }
}

class DiscountRes {
  final int status;
  final String message;
  final List<DiscountData> data;

  DiscountRes({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DiscountRes.fromJson(Map<String, dynamic> json) {
    List<dynamic> discountData = json['data'];

    List<DiscountData> discount = discountData
        .map<DiscountData>((item) => DiscountData.fromJSON(item))
        .toList();

    return DiscountRes(
      status: json['status'],
      message: json['message'],
      data: discount,
    );
  }
}
