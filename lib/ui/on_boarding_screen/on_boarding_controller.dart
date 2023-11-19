import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  int startPage = 1;
  RxInt pageCount = 3.obs;
  late PageController pageController;

  List<Map<String, String>> buildPages = [
    {
      'img': 'page-1',
      'title': 'Welcome To Buy Me',
      'subTitle': "Let's choose the best shoes from here",
    },
    {
      'img': 'page-2',
      'title': 'Choose Smart Shoes',
      'subTitle': "Choose the most attractive shoes for you",
    },
    {
      'img': 'page-3',
      'title': "Let's Go To The Store",
      'subTitle': "We are providing the best service to the customer",
    },
  ];

  void onPageChange(val) {
    startPage = val;
    update();
  }

  @override
  void onInit() {
    pageController =
        PageController(initialPage: startPage - 1, keepPage: false);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
