import 'package:buy_me/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {




  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(Routes.onBoardingScreen);
    });
  }
}
