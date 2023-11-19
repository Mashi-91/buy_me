import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<SignInController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Transform.scale(
                scaleX: -1,
                child: Image.asset('assets/images/page-1.jpg'),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: Get.height * 0.7,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(28),
                  topLeft: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03, vertical: Get.height * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Utils.titleText(text: "Forgot Password", size: 22),
                    Utils.titleText(
                        text: "Don't worry. Please send your email.",
                        size: 14,
                        fontWeight: FontWeight.normal),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    customTextField(
                      label: 'Email',
                      textController: controller.forgotPasswordController,
                    ),
                    SizedBox(height: Get.height * 0.04),
                    InkWell(
                      onTap: () {
                        if (controller
                            .forgotPasswordController.text.isNotEmpty) {
                          controller.sendPasswordLinkViaEmail();
                        }
                      },
                      child: const CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customTextField(
      {required String label, required TextEditingController textController}) {
    return GetBuilder<SignInController>(
      builder: (_) => TextField(
        controller: textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
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
      ),
    );
  }
}
