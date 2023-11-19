import 'dart:developer';

import 'package:buy_me/const/formCheckField.dart';
import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/auth_screen/sign_up_screen/sign_up_controller.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

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
                            children: [
                              Utils.titleText(text: "Create Account", size: 18),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: 'Have an account?',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        )),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Utils.customTextButton(
                                          text: 'Sign in',
                                          onTap: () {
                                            Get.back();
                                          },
                                          color: AppColors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.06,
                              ),
                              Form(
                                key: controller.signUpFormKey,
                                child: Column(
                                  children: [
                                    customTextField(
                                        label: 'Email',
                                        textController:
                                            controller.emailController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter email!';
                                          }
                                          return null;
                                        }),
                                    SizedBox(height: Get.height * 0.01),
                                    customTextField(
                                        label: 'Password',
                                        isPasswordField: true,
                                        textController:
                                            controller.passwordController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter password!';
                                          }
                                          return null;
                                        }),
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder<SignUpController>(
                                          builder: (_) => buildCheckButton(
                                            onChanged: (val) {
                                              controller.toggleTerm(val);
                                            },
                                            currentValue: controller.isTerm,
                                            validator: (val) {
                                              if (!controller.isAgreement) {
                                                controller.agreeError =
                                                    "This field must be checked";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * 0.1),
                              Utils.getRow(
                                firstWidget: Utils.titleText(
                                  text: 'Sign up',
                                  size: 22,
                                ),
                                secondWidget: InkWell(
                                  onTap: () async {
                                    if (controller.signUpFormKey.currentState!
                                            .validate() &&
                                        controller.agreeError.isEmpty &&
                                        controller.isAgreement) {
                                      await controller
                                          .signUpWithEmailAndPassword();
                                      // Get.toNamed(Routes.signUpFillScreen);
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
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'or sign in via',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade900),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Utils.circleButton(
                                      iconPath: 'google', onTap: () {}),
                                  Utils.circleButton(
                                      iconPath: 'twitter', onTap: () {}),
                                  Utils.circleButton(
                                      iconPath: 'apple', onTap: () {}),
                                ],
                              )
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
    bool? isPasswordField = false,
    required TextEditingController textController,
    required Function(String? val) validator,
  }) {
    return GetBuilder<SignUpController>(
      builder: (_) => TextFormField(
        controller: textController,
        validator: (val) => validator(val),
        keyboardType: isPasswordField!
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: isPasswordField ? controller.isPasswordVisible : false,
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
            suffixIcon: isPasswordField
                ? InkWell(
                    onTap: () {
                      controller.togglePassword();
                      log(controller.isPasswordVisible.toString());
                    },
                    child: Icon(
                        controller.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey),
                  )
                : null),
      ),
    );
  }

  Widget buildCheckButton({
    required bool currentValue,
    required Function(bool val) onChanged,
    required String? Function(bool?) validator,
  }) {
    return Flexible(
        child: CheckBoxFormFieldWithErrorMessage(
            validator: validator,
            onChanged: (val) => controller.toggleTerm(val!),
            error: controller.agreeError,
            isChecked: controller.isTerm));
  }
}
