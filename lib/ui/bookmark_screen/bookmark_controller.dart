import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final homeController = Get.find<HomeController>();
  final allShoes = StorageService.db2;
}
