import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WriteReviewController extends GetxController {
  bool recommendProduct = false;
  bool notRecommendProduct = false;
  RxDouble currentStarValue = 0.0.obs;
  final reviewController = TextEditingController();

  void recommendProductToggle(val) {
    recommendProduct = val;
    if (notRecommendProduct) recommendProduct = false;
    update();
  }

  void notRecommendProductToggle(val) {
    notRecommendProduct = val;
    if (recommendProduct) notRecommendProduct = false;
    update();
  }

  void starToggle(val) {
    currentStarValue.value = val;
  }

  void unFocus() => Get.focusScope?.unfocus();
}
