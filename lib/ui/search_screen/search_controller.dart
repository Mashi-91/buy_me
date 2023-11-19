import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductSearchController extends GetxController {
  final searchController = TextEditingController();
  List<ShoeModel> searchList = [];

  void clearSearch() {
    searchController.clear();
    update();
  }

  void searchProduct(String searchText) {
    searchList.clear();
    List searchProducts = StorageService.db2.where((text) {
      final title = text.title.toLowerCase();
      final search = searchText.toLowerCase();
      return title.contains(search);
    }).toList();
    searchList = searchProducts as List<ShoeModel>;
    update();
  }
}
