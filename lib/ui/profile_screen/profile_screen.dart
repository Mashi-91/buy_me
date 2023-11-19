import 'dart:developer';

import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:buy_me/ui/profile_screen/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildProfileAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      // Make sure to set a transparent background
                      child: GetBuilder<ProfileController>(
                        builder: (_) => ClipOval(
                          child: SizedBox(
                            width: 80, // Double the radius
                            height: 80, // Double the radius
                            child: controller.profileInfo['imageUrl'] != null &&
                                    controller.profileInfo['imageUrl'] != ''
                                ? CachedNetworkImage(
                                    imageUrl: controller.profileInfo['imageUrl']
                                        .toString(),
                                    fit: BoxFit
                                        .cover, // You can adjust the BoxFit as needed
                                  )
                                : Image.asset(
                                    'assets/images/empty_profile.png',
                                    // fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Utils.customDivider(),
            buildListView(
              firstText: 'FULL NAME',
              secondText:
                  "${controller.profileInfo['firstName'].toString()} ${controller.profileInfo['lastName'].toString()}",
            ),
            buildListView(
              firstText: 'EMAIL',
              secondText: controller.profileInfo['email'].toString(),
            ),
            buildListView(
              firstText: 'MOBILE',
              secondText: controller.profileInfo['phoneNumber'].toString(),
            ),
            buildListView(
              firstText: 'LOCATION',
              secondText: controller.profileInfo['countryName'].toString(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildProfileAppBar() {
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
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Utils.underLineText(
                    text: 'Edit',
                    onTap: () {
                      Get.toNamed(Routes.editProfileScreen);
                    },
                    padding: EdgeInsets.only(right: Get.width * 0.02)),
              ],
            ),
            Utils.customDivider(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildListView({
    required String firstText,
    required String secondText,
  }) {
    return ListView(
      padding: EdgeInsets.only(top: Get.height * 0.024),
      shrinkWrap: true,
      children: [
        Utils.titleText(
          text: firstText,
          color: Colors.grey,
        ),
        Utils.titleText(
          text: secondText.isEmpty
              ? "We don't have, go ahead add it."
              : secondText,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          size: 16,
        ),
      ],
    );
  }
}
