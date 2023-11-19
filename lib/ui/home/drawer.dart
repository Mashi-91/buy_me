import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/drawer_model.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:buy_me/ui/profile_screen/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends GetView<HomeController> {
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.11),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  // Make sure to set a transparent background
                  child: GetBuilder<ProfileController>(
                    builder: (profileController) => ClipOval(
                      child: SizedBox(
                        width: 50, // Double the radius
                        height: 50, // Double the radius
                        child: profileController.profileInfo['imageUrl'] !=
                                    null &&
                                profileController.profileInfo['imageUrl'] != ''
                            ? CachedNetworkImage(
                                imageUrl:
                                    profileController.profileInfo['imageUrl'],
                                fit: BoxFit
                                    .cover, // You can adjust the BoxFit as needed
                              )
                            : Image.asset(
                                'assets/images/empty_profile.png',
                                // fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.07),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.profileScreen);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.currentUser!.displayName.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                      backgroundColor: AppColors.lightGrey,
                      child: const Icon(Icons.close)),
                )
              ],
            ),
            SizedBox(height: Get.height * 0.04),
            Utils.customDivider(),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: ListView.builder(
                  itemCount: StorageService.drawerItem.length,
                  itemBuilder: (context, i) {
                    return Obx(
                      () => drawerTile(
                          drawerModel: DrawerModel(
                              iconData: StorageService.drawerItem[i].iconData,
                              title: StorageService.drawerItem[i].title),
                          onTap: () {
                            controller.navGo(i);
                          },
                          isSelect: i == controller.selectItem.value),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.3),
              child: Utils.customDivider(),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () {
                dialog(
                  cancelTap: () => Get.back(),
                  confirmTap: () => controller.signOut(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded, color: Colors.grey),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    const Text(
                      'Sign Out',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future dialog(
    {required VoidCallback cancelTap, required VoidCallback confirmTap}) {
  return Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      title: CircleAvatar(
        radius: 34,
        backgroundColor: AppColors.lightGrey,
        child: const Icon(
          Icons.shopping_cart,
        ),
      ),
      content: const Text(
        "Are you sure you want to log out?",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        ElevatedButton(
          onPressed: cancelTap,
          style: ElevatedButton.styleFrom(elevation: 2),
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: confirmTap,
          style: ElevatedButton.styleFrom(elevation: 2),
          child: const Text('Yes'),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
    ),
  );
}

Widget drawerTile(
    {required DrawerModel drawerModel,
    required Function onTap,
    required bool isSelect}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: isSelect ? AppColors.lightGrey : Colors.transparent,
    ),
    child: ListTile(
      selected: isSelect,
      splashColor: Colors.transparent,
      leading: Icon(
        drawerModel.iconData,
        color: isSelect ? Colors.black : Colors.grey,
      ),
      onTap: () => onTap(),
      title: Text(
        drawerModel.title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelect ? Colors.black : Colors.grey),
      ),
    ),
  );
}
