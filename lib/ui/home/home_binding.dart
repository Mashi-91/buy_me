import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:buy_me/ui/cart_screen/cart_controller.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:buy_me/ui/on_boarding_screen/on_boarding_controller.dart';
import 'package:buy_me/ui/profile_screen/profile_controller.dart';
import 'package:buy_me/ui/search_screen/search_controller.dart';
import 'package:get/get.dart';

import 'write_review_screen/write_review_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => OnBoardingController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => WriteReviewController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => ProductSearchController());
    Get.lazyPut(() => ProfileController());
  }
}
