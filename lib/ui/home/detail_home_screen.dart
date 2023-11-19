import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/cart_model.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/ui/cart_screen/cart_controller.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DetailHomeScreen extends GetView<HomeController> {
  DetailHomeScreen({super.key});

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments;
    ShoeModel shoes = argument as ShoeModel;
    return Scaffold(
      appBar: buildCustomAppBar(
        detailAppBar: Container(
          height: Get.height * 0.3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(shoes.img))),
        ),
        isDetailAppBar: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(top: Get.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.9,
                child: Utils.getRow(
                  firstWidget: Text(
                    shoes.category.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  secondWidget: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                            child: Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 18,
                        )),
                        TextSpan(
                            text: "(${shoes.rating})",
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Utils.getRow(
                  firstWidget: SizedBox(
                    width: Get.textScaleFactor * 230,
                    child: Text(
                      shoes.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  secondWidget: Text(
                    "\$${shoes.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 20),
              Utils.getRow(
                  firstWidget: const Text(
                    'Size',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  secondWidget: ToggleSwitch(
                    onToggle: (val) => controller.changeToggle(val),
                    inactiveBgColor: Colors.white,
                    activeBgColor: const [Colors.grey],
                    minWidth: 40,
                    minHeight: 34,
                    radiusStyle: true,
                    inactiveFgColor: Colors.grey,
                    labels: const ['US', 'UK', 'EU'],
                    totalSwitches: 3,
                    initialLabelIndex: 0,
                  )),
              const SizedBox(height: 14),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleSwitch(
                  onToggle: (val) => controller.sizeSelectInNumbers,
                  inactiveBgColor: AppColors.cardColor,
                  activeBgColor: const [Colors.deepOrange],
                  radiusStyle: true,
                  dividerColor: Colors.white,
                  dividerMargin: 0,
                  minWidth: 70,
                  minHeight: 60,
                  inactiveFgColor: Colors.grey,
                  labels: StorageService.detailSizeLabel,
                  totalSwitches: StorageService.detailSizeLabel.length,
                  initialLabelIndex: 0,
                ),
              ),
              const SizedBox(height: 10),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: const Border(),
                collapsedIconColor: Colors.black,
                children: [
                  Text(
                    shoes.descriptions.toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Utils.customDivider(),
              const ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Free Delivery and Returns',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: Border(),
                collapsedIconColor: Colors.black,
                childrenPadding: EdgeInsets.zero,
                children: [
                  Row(
                    children: [
                      Icon(Icons.done, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Standard delivered 2-6 Business Days",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.done, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Express delivered 2-4 Business Days",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Orders are processed and delivered Monday-Friday (excluding public holiday)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Utils.customDivider(),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Product Reviews (10)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: const Border(),
                collapsedIconColor: Colors.black,
                childrenPadding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Utils.underLineText(
                        text: 'Write a Review',
                        onTap: () {
                          Get.toNamed(Routes.writeReviewScreen);
                        },
                      ),
                      Utils.underLineText(
                        text: 'See All',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  reviewCard(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: Get.height * 0.01),
        child: Row(
          children: [
            GetBuilder<HomeController>(builder: (_) {
              final id = shoes.id;
              bool isFav = controller.isFavorite(shoes.id!.toInt());
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  controller.toggleFav(id);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(left: 10, right: 20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)),
                  child: Icon(isFav ? Icons.bookmark : Icons.bookmark_outline),
                ),
              );
            }),
            customButton(
                title: 'Add to Cart',
                onTap: () {
                  cartController.addToCart(
                      cartModel: CartModel(shoeModel: shoes, id: shoes.id));
                },
                color: Colors.black,
                width: Get.width * 0.72,
                height: 56)
          ],
        ),
      ),
    );
  }

  Row reviewCard() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(profilePath),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Danish Mehrab',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              StorageService.review,
              style: TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
