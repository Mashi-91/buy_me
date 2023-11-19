import 'dart:developer';

import 'package:buy_me/const/const.dart';
import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/add_creditCard_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/payment_screen/payment_controller.dart';
import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(title: 'Payment Method'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.07, vertical: Get.height * 0.04),
        child: controller.cardList.length != 0
            ? Column(
                children: [
                  GetBuilder<PaymentController>(
                    builder: (_) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.cardList.length,
                      itemBuilder: (context, i) {
                        return buildCardList(
                          creditCardModel: controller.cardList[i],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  customButton(
                    title: 'Add New card',
                    onTap: () {
                      Get.toNamed(Routes.addNewCardScreen);
                    },
                    icon: Icon(Icons.add, color: Colors.black),
                    color: AppColors.lightGrey,
                    textColor: Colors.black,
                    height: 80,
                    borderRadius: 12,
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/empty_card.png'),
                        SizedBox(height: Get.height * 0.1),
                        Utils.titleText(text: "Don't have any card", size: 20),
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          width: Get.width * 0.7,
                          child: Utils.titleText(
                            text: emptyPaymentText,
                            color: Colors.grey,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  customOutlineButton(
                    title: 'Add Credit Cards',
                    onTap: () {
                      Get.toNamed(Routes.addNewCardScreen);
                      log(controller.cardList.length.toString());
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildCardList({required AddCreditCardModel creditCardModel}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.02),
      child: GetBuilder<PaymentController>(
        builder: (_) {
          final isSelected = controller.selectCard == creditCardModel;

          return ListTile(
            style: ListTileStyle.list,
            tileColor: AppColors.lightGrey,
            onTap: () {
              controller.toggleSelectCard(creditCardModel);
              log(isSelected.toString());
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Utils.titleText(
                text: controller.switchCardType(
                    creditCardModel.cardType ?? CardType.invalid)),
            subtitle: Row(
              children: [
                Image.asset(
                  controller.switchCardImage(
                      creditCardModel.cardType ?? CardType.invalid),
                  height: 26,
                ),
                SizedBox(width: Get.width * 0.03),
                Utils.titleText(
                  text: Utils.maskCreditCard(
                      creditCardModel.cardNumber.toString()),
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            trailing:  Icon(
              isSelected ?
                  Icons.done : null,
                  color: AppColors.deepOrange,
                ),
          );
        },
      ),
    );
  }
}
