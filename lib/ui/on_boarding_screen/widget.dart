import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/utils/custom_button.dart';

Widget buildPage(
    {required String img,
    required String title,
    required String subTitle,
    required int currentPage,
    required Function(int val) onPage,
    required Function backTap,
    required Function goTap,
    required BuildContext context,
    bool isLast = false}) {
  return LayoutBuilder(
    builder: (context, constraint) => Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/$img.jpg',
                ),
                alignment: Alignment.topCenter),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                isLast ? Colors.black : Colors.black87,
                Colors.black,
              ],
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
        Positioned(
          bottom: isLast
              ? (constraint.maxHeight / 10)
              : (constraint.maxHeight / 10),
          left: isLast
              ? (constraint.maxHeight / 26)
              : (constraint.maxHeight / 10),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.textScaleFactor * 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 210,
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: currentPage.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const TextSpan(
                        text: '/',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        )),
                    TextSpan(
                        text: '3',
                        style: TextStyle(
                          color: isLast ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  InkWell(
                    onTap: () => backTap(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: currentPage == 1 ? Colors.grey : Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  DotsIndicator(
                    dotsCount: 3,
                    onTap: (val) => onPage(val),
                    position: currentPage - 1,
                    decorator: DotsDecorator(
                        activeSize: const Size(3, 10),
                        activeColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Colors.grey,
                        size: const Size(3, 5),
                        spacing: const EdgeInsets.symmetric(horizontal: 3)),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: isLast ? null : () => goTap(),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              isLast
                  ? customButton(
                      title: 'Get Started',
                      onTap: () => goTap(),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    ),
  );
}
