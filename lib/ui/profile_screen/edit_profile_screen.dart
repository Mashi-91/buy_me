import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:buy_me/ui/profile_screen/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends GetView<ProfileController> {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildProfileAppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                      GetBuilder<ProfileController>(
                        builder: (_) => CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          // Make sure to set a transparent background
                          child: ClipOval(
                            child: SizedBox(
                              width: 80, // Double the radius
                              height: 80, // Double the radius
                              child: controller.saveImage != null &&
                                      controller.saveImage != ''
                                  ? Image.file(
                                      controller.saveImage!,
                                      fit: BoxFit.cover,
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
                          onTap: () {
                            controller.pickImage();
                          },
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
                firstText: 'FIRST NAME',
                widget: customTextField(
                  textEditingController: controller.firstNameController,
                ),
              ),
              buildListView(
                firstText: 'LAST NAME',
                widget: customTextField(
                  textEditingController: controller.lastNameController,
                ),
              ),
              buildListView(
                firstText: 'EMAIL',
                widget: customTextField(
                  textEditingController: controller.emailController,
                ),
              ),
              buildListView(
                firstText: 'MOBILE',
                widget: customTextField(
                  textEditingController: controller.phoneController,
                ),
              ),
              buildListView(
                firstText: 'LOCATION',
                widget: customTextField(
                  textEditingController: controller.countryController,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customOutlineButton(
                    title: 'Cancel',
                    onTap: () {
                      Get.back();
                    },
                    width: Get.width * 0.4,
                  ),
                  customButton(
                    title: 'Save',
                    onTap: () {
                      if (controller.firstNameController.text.isNotEmpty ||
                          controller.lastNameController.text.isNotEmpty ||
                          controller.emailController.text.isNotEmpty ||
                          controller.phoneController.text.isNotEmpty ||
                          controller.countryController.text.isNotEmpty) {
                        controller.updateData();
                        Utils.showOverlayLoading();
                      }
                    },
                    width: Get.width * 0.4,
                  ),
                ],
              )
            ],
          ),
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
                    onTap: () {
                      controller.getData();
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Spacer(),
                const Text(
                  'Edit Profile',
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
}
