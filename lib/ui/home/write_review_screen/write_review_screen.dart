import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/ui/home/write_review_screen/write_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';

class WriteReviewScreen extends GetView<WriteReviewController> {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final shoe = Get.arguments;
    return Scaffold(
      appBar: buildCustomAppBar(title: 'Write Review'),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.titleText(text: 'What do you recommend for this product ?'),
              const SizedBox(height: 10),
              GetBuilder<WriteReviewController>(
                builder: (_) => Utils.getRow(
                  firstWidget: Row(
                    children: [
                      Utils.switchButton(
                          value: controller.recommendProduct,
                          onTap: (val) =>
                              controller.recommendProductToggle(val)),
                      const SizedBox(width: 8),
                      const Text(
                        'Yes',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  secondWidget: Row(
                    children: [
                      Utils.switchButton(
                          value: controller.notRecommendProduct,
                          onTap: (val) =>
                              controller.notRecommendProductToggle(val)),
                      const SizedBox(width: 8),
                      const Text(
                        'No',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Utils.titleText(text: 'Rating for this product'),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    RatingStars(
                      maxValue: 5.0,
                      starColor: AppColors.orange,
                      value: controller.currentStarValue.value,
                      starSize: 28,
                      starBuilder: (i, color) {
                        return Icon(Icons.star_purple500_outlined,
                            color: color, size: 28);
                      },
                      onValueChanged: (val) => controller.starToggle(val),
                      valueLabelVisibility: false,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${controller.currentStarValue.value.toInt()}/5',
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Utils.titleText(text: 'Write Your Review'),
              const SizedBox(height: 20),
              TextField(
                controller: controller.reviewController,
                onTapOutside: (val) => controller.unFocus(),
                textInputAction: TextInputAction.newline,
                maxLines: 5,
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Write your review here",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lightGrey, width: 2)),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Utils.titleText(text: "Add Photo", size: 15),
              const SizedBox(height: 6),
              Utils.addButton(onTap: () {}, size: 20),
              const SizedBox(height: 90),
              customOutlineButton(
                title: 'Submit Review',
                onTap: () {},
                height: 60,
                borderColor: Colors.grey.withOpacity(0.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
