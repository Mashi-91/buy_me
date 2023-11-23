import 'dart:developer';

import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/home/home_screen.dart';
import 'package:buy_me/ui/profile_screen/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin {
  final scaffoldKey1 = GlobalKey<ScaffoldState>();
  final selectItem = 0.obs;
  int sizeSelectInCountryBase = 0;
  int sizeSelectInNumbers = 0;
  int sizeSelectInGender = 0;
  int filterLogoIndex = 0;
  List favList = [];
  int currentIndex = 0;
  late List<Widget> tabsView;
  List<ShoeModel> filterData = [];
  final currentUser = AuthService.firebase().currentUser?.user;

  final profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    _fetchData();
    profileController.getData();
    tabsView = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
  }

  Future<void> _fetchData() async {
    try {
      await StorageService.getAllProducts();
      await getAllData();
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAllData() async {
    try {
      filterData = StorageService.db2.where((data) {
        switch (currentIndex) {
          case 0:
            return true; // Show all data
          case 1:
            return data.category == "jewelery";
          case 2:
            return data.category == "men's clothing" ||
                data.category == "women's clothing";
          case 3:
            return data.category == "electronics";
          default:
            return false; // Handle invalid currentIndex if needed
        }
      }).toList();
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    Get.back(closeOverlays: true);
    await AuthService.firebase().logOut();
    Get.offNamedUntil(Routes.signInScreen, (route) => false);
  }

  void changeToggle(val) {
    sizeSelectInCountryBase = val;
    update();
  }

  void changeFilterLogoToggle(val) {
    filterLogoIndex = val;
    update();
  }

  void navGo(int i) {
    switch (i) {
      case 0:
        Get.toNamed(Routes.homeScreen);
        Get.back();
      case 1:
        Get.toNamed(Routes.bookMarkScreen);
        break;
      case 2:
        Get.toNamed(Routes.cartScreen);
      case 3:
        Get.toNamed(Routes.paymentScreen);
    }
  }

  void toggleFav(id) {
    if (favList.contains(id)) {
      favList.remove(id);
      Utils.snackBar(
          title: 'Remove from Bookmark',
          msg: 'Your item has been removed from bookmark');
    } else {
      favList.add(id);
      Utils.snackBar(
          title: 'Add to Bookmark',
          msg: 'Your item has been saved in bookmark');
    }
    update();
  }

  bool isFavorite(int itemId) {
    return favList.contains(itemId);
  }

  void removeItem(int itemId) {
    favList.removeAt(itemId);
    update();
  }

  String switchCategory(ShoeModel shoes) {
    if (shoes.category == Category.women) {
      return "Women's Shoes";
    } else if (shoes.category == Category.men) {
      return "Men's Shoes";
    }
    return "Kid's Shoes";
  }

  List<Widget> tabs = [
    const Text("All"),
    const Text("Jewelery"),
    const Text("Clothes"),
    const Text("Electronics"),
  ];
}
