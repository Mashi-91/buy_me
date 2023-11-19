import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/ui/auth_screen/sign_up_screen/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFillScreen extends GetView<SignUpController> {
  const SignUpFillScreen({super.key});

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
            child: SingleChildScrollView(
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: Obx(
                    () => controller.showLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.deepOrange,
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                  width: Get.width * 0.6,
                                  child: Utils.titleText(
                                      text:
                                          "We just need some more information",
                                      size: 20)),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              Form(
                                key: controller.fillFormKey,
                                child: Column(
                                  children: [
                                    customTextField(
                                      label: 'FIRST NAME',
                                      textController:
                                          controller.firstNameController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please Enter your first name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    customTextField(
                                      label: 'LAST NAME',
                                      textController:
                                          controller.lastNameController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please Enter your last name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    customTextField(
                                      label: 'COUNTRY',
                                      textController:
                                          controller.countryController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please Enter your country name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    customTextField(
                                      label: 'PHONE',
                                      textController:
                                          controller.phoneController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please Enter your phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    customTextField(
                                      label: 'WHAT DO YOU WANT TO BUY?',
                                      textController:
                                          controller.questionController,
                                      validator: (val) {},
                                    ),
                                    SizedBox(height: Get.height * 0.07),
                                    Utils.getRow(
                                      firstWidget: Utils.titleText(
                                        text: 'Sign up',
                                        size: 22,
                                      ),
                                      secondWidget: InkWell(
                                        onTap: () {
                                          if (controller
                                              .fillFormKey.currentState!
                                              .validate()) {
                                            controller.storeDataInFireStore();
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
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customTextField({
    required String label,
    required TextEditingController textController,
    TextInputType? textInputType,
    required Function(String? val) validator,
  }) {
    return GetBuilder<SignUpController>(
      builder: (_) => TextFormField(
        validator: (val) => validator(val),
        keyboardType: textInputType ?? TextInputType.text,
        controller: textController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
