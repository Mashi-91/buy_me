import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/on_boarding_screen/on_boarding_controller.dart';
import 'package:buy_me/ui/on_boarding_screen/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => PageView.builder(
        onPageChanged: (val) {
          controller.onPageChange(val);
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: controller.pageCount.value,
        itemBuilder: (context, i) {
          return buildPage(
            img: controller.buildPages[i]['img'].toString(),
            title: controller.buildPages[i]['title'].toString(),
            subTitle: controller.buildPages[i]['subTitle'].toString(),
            context: context,
            isLast: i == 2 ? true : false,
            backTap: () {
              controller.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInCubic,
              );
            },
            onPage: (val) => controller.onPageChange(val),
            goTap: () {
              controller.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInCubic,
              );
              if (i == 2) {
                Get.offNamedUntil(Routes.authScreen, (route) => false);
              }
            },
            currentPage: i + 1,
          );
        },
      ),
    ));
  }
}
