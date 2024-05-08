import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/button_shadow.dart';
import 'package:my_app/common_widgets/modalNotification.dart';
import 'package:my_app/main.dart';
import 'package:my_app/services/orders/all-address-order.svc.dart';

class AddNewAddressOrderView extends StatefulWidget {
  const AddNewAddressOrderView({
    Key? key,
  }) : super(key: key);

  @override
  _AddNewAddressOrderViewState createState() => _AddNewAddressOrderViewState();
}

class _AddNewAddressOrderViewState extends State<AddNewAddressOrderView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final userId = prefs?.getString('userId') ?? '';

  void addNewAddress() async {
    AllAddressOrderService.addNewAddressOrder({
      "userId": userId,
      "receiverName": nameController.text,
      "phone": phoneController.text,
      "addressOrder": addressController.text,
    }).then((value) {
      const ModalNotification(
          titleContent: 'Thêm địa chỉ thành công', titleHeader: 'Thông báo');

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          'THÊM ĐỊA CHỈ GIAO HÀNG',
          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTextField('Họ và tên', Colors.black, nameController,
                    TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField('Số điện thoại', null, phoneController,
                    TextInputType.phone),
                const SizedBox(height: 20),
                _buildTextField('Địa chỉ', null, addressController,
                    TextInputType.streetAddress),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ButtonShadowWidget(
                    title: 'Thêm địa chỉ',
                    onPressed: () {
                      addNewAddress();
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, Color? labelColor, TextEditingController controller,
      [TextInputType? inputType]) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: labelColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
