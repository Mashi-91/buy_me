import 'dart:developer';
import 'dart:ui';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/cart_screen/cart_controller.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: cartAppBar(actionTitle: 'See Bookmark list'),
        body: controller.cartList.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.52,
                    child: ListView.builder(
                        itemCount: controller.cartList.length,
                        itemBuilder: (context, i) {
                          final key = controller.cartList[i].id;
                          return Slidable(
                            key: ValueKey(key),
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                              extentRatio: Get.pixelRatio * 0.09,
                              motion: const ScrollMotion(),
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.removeItem(i);
                                  },
                                  child: Container(
                                    height: Get.height * 0.15,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.deepOrange,
                                      size: 32,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            child: cartTile(
                              shoeModel: controller.cartList[i].shoeModel,
                              i: i,
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14)
                        .copyWith(bottom: Get.height * 0.02),
                    child: Column(
                      children: [
                        Utils.dottedDivider(),
                        const SizedBox(height: 30),
                        textSection(
                            firstText: "Delivery Fee", secondText: "00"),
                        textSection(firstText: "Discount", secondText: "00"),
                        textSection(
                            firstText: "Total",
                            secondText: "${controller.totalPrice()}"),
                        customButton(
                          title: 'Add more Item',
                          onTap: () => Get.offNamed(Routes.homeScreen),
                          color: AppColors.lightGrey,
                          textColor: Colors.black,
                          icon: const Icon(Icons.add),
                          borderRadius: 12,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        customButton(
                          title: 'Checkout',
                          onTap: () => controller.checkOut(),
                          color: Colors.black,
                          height: 60,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.1),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/empty_cart.png',
                        alignment: Alignment.bottomCenter,
                      ),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      const Text(
                        'Opps!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Your Cart is Empty...",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: customButton(
                            title: 'Add Product',
                            width: Get.width * 0.9,
                            color: Colors.black,
                            onTap: () {
                              Get.offAllNamed(Routes.tab_controller_screen);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Widget cartTile({
  required ShoeModel shoeModel,
  required int i,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    padding: EdgeInsets.symmetric(horizontal:  Get.width * 0.01, vertical: 16),
    decoration: BoxDecoration(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: shoeModel.img,
          height: 60,
        ),
        SizedBox(width: Get.width * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.6,
              child: Text(
                shoeModel.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text("\$${shoeModel.price.toStringAsFixed(2)}"),
            const SizedBox(height: 8),
            GetBuilder<CartController>(
              builder: (controller) {
                var count = controller.count;
                return customCartStepperButton(
                    incrementTap: () => controller.increment(),
                    decrementTap: () => controller.decrement(),
                    text: count);
              },
            )
          ],
        ),
        const Spacer(),
        GetBuilder<HomeController>(builder: (controller) {
          final id = i + 1;
          final isFavorite = controller.isFavorite(id);
          return IconButton(
            icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_outline),
            onPressed: () => controller.toggleFav(id),
          );
        })
      ],
    ),
  );
}

Widget textSection({required String firstText, required String secondText}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Utils.getRow(
      firstWidget: Text(
        firstText,
        style: const TextStyle(fontSize: 16),
      ),
      secondWidget: Text(
        "\$$secondText",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
