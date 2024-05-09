import 'package:flutter/material.dart';
import 'package:my_app/model/discount.model.dart';
import 'package:my_app/services/discount/discount.svc.dart';
import 'package:my_app/widgets/discount_card_widget.dart';

class ListDiscount extends StatefulWidget {
  const ListDiscount({super.key});

  @override
  State<ListDiscount> createState() => _nameSListDiscount();
}

class _nameSListDiscount extends State<ListDiscount> {
  List<DiscountData> allDiscount = [];

  void fetchAllDiscount() async {
    DiscountProduct.getAll().then((value) {
      setState(() {
        allDiscount = value.data;
      });
      print(value);
    }).catchError((error) {
      print('Error getting all discount: $error');
    });
  }

  @override
  void initState() {
    super.initState();

    fetchAllDiscount();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allDiscount.length,
      itemBuilder: (context, index) {
        final discount = allDiscount[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: DiscountCard(
            name: discount.nameDiscount,
            minValue: discount.minValue,
            nameCode: discount.code,
            maxValue: discount.maxValue,
          ),
        );
      },
    );
  }
}
