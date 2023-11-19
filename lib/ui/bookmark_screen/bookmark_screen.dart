import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_appBar.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/bookmark_screen/bookmark_controller.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkScreen extends GetView<BookmarkController> {
  BookmarkScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: buildCustomAppBar(
          title: 'Bookmarks',
        ),
        body: homeController.favList.isNotEmpty
            ? ListView.builder(
                itemCount: homeController.favList.length,
                itemBuilder: (context, i) {
                  final shoeId = homeController.favList[i] - 1;
                  if (shoeId >= 0 && shoeId < controller.allShoes.length) {
                    final shoe = controller.allShoes[i];
                    return bookMarkTile(
                      shoeModel: shoe,
                      onRemove: () {
                        homeController.removeItem(i);
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                })
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.1),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/bookmark_empty.png',
                        alignment: Alignment.bottomCenter,
                      ),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      const Text(
                        'Opps!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "You've Not Added Any Bookmarks",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: customButton(
                            title: 'Add Bookmark',
                            width: Get.width * 0.9,
                            color: Colors.black,
                            onTap: () {
                              Get.offAllNamed(Routes.homeScreen);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Widget bookMarkTile(
    {required ShoeModel shoeModel, required Function onRemove}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: ListTile(
      tileColor: AppColors.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      leading: CachedNetworkImage(imageUrl: shoeModel.img),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shoeModel.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("\$${shoeModel.price.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          customButton(
            title: 'Add to Cart',
            onTap: () {},
            color: Colors.black,
            width: 100,
            height: 30,
            textSize: 10,
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.bookmark_outlined),
        onPressed: () => onRemove(),
      ),
    ),
  );
}
