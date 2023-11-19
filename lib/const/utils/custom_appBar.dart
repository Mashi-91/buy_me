import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/cart_screen/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildHomeAppBar({
  required Function onTapDrawer,
  required Function onTapSearch,
  required PreferredSizeWidget? bottom,
}) {
  return AppBar(
    surfaceTintColor: Colors.white,
    leading: InkWell(
      onTap: () => onTapDrawer(),
      child: const Icon(Icons.sort),
    ),
    actions: [
      InkWell(
          onTap: () => onTapSearch(), child: const Icon(Icons.search_outlined)),
      GetBuilder<CartController>(
        builder: (controller) => buildSideCart(
          count: controller.countCart,
        ),
      ),
    ],
    bottom: bottom,
  );
}

AppBar buildCustomAppBar({
  String? title,
  Function? onTap,
  bool isBack = false,
  bool isDetailAppBar = false,
  Function? onTapCart,
  Widget? detailAppBar,
}) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    leading: isBack
        ? InkWell(onTap: () => onTap!(), child: const Icon(Icons.arrow_back))
        : null,
    title: Text(
      title ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      isDetailAppBar
          ? GetBuilder<CartController>(
              builder: (controller) =>
                  buildSideCart(count: controller.countCart))
          : Container(),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(
          !isDetailAppBar ? Get.height * 0.02 : Get.height * 0.28),
      child: !isDetailAppBar ? Utils.customDivider() : detailAppBar as Widget,
    ),
  );
}

AppBar cartAppBar({required String actionTitle}) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back)),
                InkWell(
                  onTap: () => Get.toNamed(Routes.bookMarkScreen),
                  child: Text(actionTitle,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        decorationStyle: TextDecorationStyle.double,
                        decorationThickness: 1,
                      )),
                ),
              ],
            ),
          ),
          Utils.customDivider(),
        ],
      ),
    ),
  );
}

Widget buildSideCart({int count = 0}) {
  return InkWell(
    onTap: () {
      Get.toNamed(Routes.cartScreen);
      log('message');
    },
    child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          height: 42,
          padding: const EdgeInsets.only(right: 20, left: 6),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: const Icon(
            Icons.shopping_bag,
            color: Colors.white,
            size: 23,
          ),
        ),
        if (count != 0)
          Positioned(
            right: 16,
            top: 8,
            child: Container(
              alignment: Alignment.center,
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: AppColors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    ),
  );
}

AppBar buildAppBar({required String title}) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.02),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Spacer(),
            ],
          ),
          Utils.customDivider(height: 10),
        ],
      ),
    ),
  );
}
