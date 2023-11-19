import 'dart:convert';
import 'dart:developer';

import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/drawer_model.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StorageService {
  // static final db = [
  //   ShoeModel(
  //     id: 1,
  //     img: 'assets/images/shoe-2.png',
  //     title: 'Nike Air Max 95',
  //     category: Category.women,
  //     price: 290.00,
  //     rating: 4.5,
  //     descriptions:
  //         'A redesigned Zoom Air unit with a larger compression platform gives you more cushioning when jumping or lifting, while a low-profile heel stabilizer gives you more support during highly technical maneuvers. The midsole cage interlocks with the lace closure at the midfoot to increase grip where you need it the most.',
  //   ),
  //   ShoeModel(
  //     id: 2,
  //     img: 'assets/images/shoe-3.png',
  //     title: 'Nike Air',
  //     category: Category.men,
  //     price: 290.00,
  //     rating: 4.0,
  //     descriptions:
  //         'A redesigned Zoom Air unit with a larger compression platform gives you more cushioning when jumping or lifting, while a low-profile heel stabilizer gives you more support during highly technical maneuvers. The midsole cage interlocks with the lace closure at the midfoot to increase grip where you need it the most.',
  //   ),
  //   ShoeModel(
  //     id: 3,
  //     img: 'assets/images/shoe-4.png',
  //     title: 'Nike Shoes',
  //     category: Category.men,
  //     price: 390.00,
  //     rating: 3.9,
  //     descriptions:
  //         'A redesigned Zoom Air unit with a larger compression platform gives you more cushioning when jumping or lifting, while a low-profile heel stabilizer gives you more support during highly technical maneuvers. The midsole cage interlocks with the lace closure at the midfoot to increase grip where you need it the most.',
  //   ),
  // ];

  static List<ShoeModel> db2 = [];

  static Future getAllProducts() async {
    final url = Uri.parse("https://fakestoreapi.com/products");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        db2.addAll( jsonData
            .map((e) => ShoeModel.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        throw HttpException("Failed to load products", response.statusCode);
      }
    } catch (error) {
      throw HttpException("An error occurred while fetching data", 0);
    }
  }



  static final List<String> detailSizeLabel = ['5', '5.5', '6', '6.6', '7'];
  static final List<String> detailGenderLabel = ['Men', 'Women', 'UniSex'];
  static final List<String> filterLogo = [
    'assets/icon/Nike.svg',
    'assets/icon/Puma.svg',
    'assets/icon/Jordan.svg',
  ];

  static final List<DrawerModel> drawerItem = [
    DrawerModel(id: '1', iconData: Icons.home_outlined, title: 'Home'),
    DrawerModel(
        id: '2', iconData: Icons.bookmark_outline_outlined, title: 'Bookmarks'),
    DrawerModel(id: '3', iconData: Icons.list_alt_outlined, title: 'Orders'),
    DrawerModel(id: '4', iconData: Icons.credit_card, title: 'Payment Methods'),
    DrawerModel(id: '5', iconData: Icons.notifications, title: 'Notifications'),
    DrawerModel(
        id: '6', iconData: Icons.person_add_alt_1, title: 'Refer to Friends'),
    DrawerModel(id: '7', iconData: Icons.info, title: 'About Us'),
  ];

  static const review =
      "The most comfortable Nike's I've wom in the past couple of years has been the 32s.These have surpassed that. They look amazing and have comfort. You can see where this review is going.";
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);
}
