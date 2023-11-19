import 'dart:developer';

import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/const/utils/shoe_card.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:buy_me/ui/cart_screen/cart_controller.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) => SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHomeShoeCard(),
                const SizedBox(height: 20),
                const Text(
                  'Recommended For You',
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: /*MediaQuery.of(context).size.width < 600 ? */ Get.height * 0.36 * 3 /*: Get.height * 1.08*/ ,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int itemCount = controller.filterData.length;
                      int itemsToShow =
                          constraints.maxHeight < 600 ? 3 : itemCount;
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemsToShow,
                          itemBuilder: (context, i) {
                            final id = i + 1;
                            final model = ShoeModel(
                                img: controller.filterData[i].img,
                                title: controller.filterData[i].title,
                                category: controller.filterData[i].category,
                                price: controller.filterData[i].price);
                            return Column(
                              children: [
                                buildShoeCard(
                                    shoeModel: model,
                                    isFav: controller.isFavorite(id.toInt()),
                                    FavButton: () {
                                      controller.toggleFav(id);
                                    },
                                    detailButton: () {
                                      Get.toNamed(Routes.detailHomeScreen,
                                          arguments: controller.filterData[i]);
                                    }),
                                const SizedBox(height: 20)
                              ],
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
