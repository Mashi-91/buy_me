import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/add_creditCard_model.dart';
import 'package:buy_me/ui/payment_screen/payment_controller.dart';
import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCreditCardScreen extends GetView<PaymentController> {
  const AddCreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(title: 'Add New Card'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.07, vertical: Get.height * 0.08),
          child: Column(
            children: [
              CreditCardForm(
                onChanged: (val) {
                  controller.getValue(val);
                  final type = controller.result?.cardHolderName;
                  log(type.toString());
                },
              ),
              SizedBox(height: Get.height * 0.1),
              customOutlineButton(
                title: 'Add Card',
                onTap: () async {
                  if (controller.result?.cardType !=
                      CardType.invalid) {
                    await controller.savedCard().then((value) => Get.back());
                  } else {
                    Utils.snackBar(
                        title: 'Invalid Card',
                        msg: 'Enter a valid card number');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField({
    required TextEditingController textEditingController,
  }) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        fillColor: AppColors.lightGrey,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
      ),
    );
  }

  Widget buildListView({
    required String firstText,
    required Widget widget,
  }) {
    return ListView(
      padding: EdgeInsets.only(top: Get.height * 0.024),
      shrinkWrap: true,
      children: [
        Utils.titleText(
          text: firstText,
          color: Colors.grey,
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        widget,
      ],
    );
  }
}
