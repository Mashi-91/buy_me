import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/search_screen/search_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<ProductSearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12).copyWith(top: Get.height * 0.05),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      autofocus: true,
                      controller: controller.searchController,
                      onChanged: (val) => controller.searchProduct(val),
                      decoration: InputDecoration(
                          hintText: "Search Products",
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          focusColor: AppColors.lightGrey,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.lightGrey),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller
                          .searchProduct(controller.searchController.text);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 14),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        color: Colors.black,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            GetBuilder<ProductSearchController>(builder: (_) {
              if (controller.searchController.text.isEmpty) {
                return Image.asset(
                  "assets/images/search_image.jpg",
                  height: Get.pixelRatio * 200,
                );
              } else if (controller.searchList.isEmpty) {
                return Image.asset(
                  "assets/images/no-products.jpg",
                  height: Get.pixelRatio * 200,
                );
              } else {
                return SizedBox(
                  height: Get.height * 0.87,
                  child: ListView.builder(
                    itemCount: controller.searchList.length,
                    itemBuilder: (context, i) {
                      return searchContainer(
                        shoeModel: controller.searchList[i],
                        onTap: () {
                          Get.toNamed(Routes.detailHomeScreen,
                              arguments: controller.searchList[i]);
                        },
                      );
                    },
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget searchContainer(
      {required ShoeModel shoeModel, required Function onTap}) {
    return Stack(
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16)
                  .copyWith(bottom: 14),
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03)
                  .copyWith(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                /* boxShadow: const [
                BoxShadow(
                  offset: Offset(0,4),
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ]*/
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                        imageUrl: shoeModel.img, height: 140),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    shoeModel.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    shoeModel.category.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${shoeModel.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
