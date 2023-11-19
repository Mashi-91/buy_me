import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

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
                          ))
                        : ListView(
                            shrinkWrap: true,
                            children: [
                              Utils.titleText(
                                  text: "Let's you Sign in", size: 18),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: 'New here?',
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
                                          text: 'Sign up',
                                          onTap: () {
                                            controller
                                                .signInFormKey.currentState
                                                ?.reset();
                                            Get.toNamed(Routes.signUpScreen);
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
                                key: controller.signInFormKey,
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
                                            return 'Please enter password';
                                          }
                                          return null;
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GetBuilder<SignInController>(
                                    builder: (_) => buildSwitchButton(
                                      onChanged: (val) {
                                        controller.toggleRemember(val);
                                      },
                                      currentValue: controller.isRemember,
                                    ),
                                  ),
                                  Utils.customTextButton(
                                    text: 'Forgot password?',
                                    fontWeight: FontWeight.w100,
                                    onTap: () {
                                      Get.toNamed(Routes.forgotPasswordScreen);
                                    },
                                    size: 12,
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.1),
                              Utils.getRow(
                                firstWidget: Utils.titleText(
                                  text: 'Sign in',
                                  size: 22,
                                ),
                                secondWidget: InkWell(
                                  onTap: () {
                                    if (controller.signInFormKey.currentState!
                                        .validate()) {
                                      controller.signInWithEmailAndPassword();
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
    return GetBuilder<SignInController>(
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

  Widget buildSwitchButton({
    required bool currentValue,
    required Function(bool val) onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          height: 34,
          width: 44,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: currentValue,
              onChanged: onChanged,
              activeColor: AppColors.deepOrange,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.white,
              trackOutlineWidth: MaterialStateProperty.all(2),
            ),
          ),
        ),
        const SizedBox(width: 2),
        const Text(
          'Remember Me',
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
