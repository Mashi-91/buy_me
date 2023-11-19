import 'dart:convert';
import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Utils {
  static Widget customDivider({double? height}) {
    return Divider(
      height: height,
      color: AppColors.lightGrey,
      thickness: 2,
    );
  }

  static Widget getRow({required Widget firstWidget,
    Widget? secondWidget,
    MainAxisAlignment? mainAxisAlignment}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        firstWidget,
        secondWidget ?? Container(),
      ],
    );
  }

  static Widget underLineText(
      {required String text, required Function onTap, EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () => onTap(),
        child: Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 4,
            )),
      ),
    );
  }

  static Future showBottomSheet({required Widget widget}){
    return Get.bottomSheet(
        Container(
          height: Get.height * 0.9,
          child: widget
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      isScrollControlled: true,
    );
  }

  static Widget titleText({required String text,
    double? size,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? color}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        letterSpacing: 0,
        fontSize: size ?? 14,
        color: color,
      ),
    );
  }

  static String maskCreditCard(String cardNumber) {
    if (cardNumber.length >= 4) {
      final maskedStart = cardNumber.substring(0, 4); // First 4 characters
      final maskedEnd =
      cardNumber.substring(cardNumber.length - 4); // Last 4 characters
      final maskedMid =
          '*' * (cardNumber.length - 8); // Middle characters masked with '*'

      return '$maskedStart $maskedMid $maskedEnd';
    } else {
      // Handle cases where the card number is too short
      return 'Invalid Card Number';
    }
  }

  static Widget customLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.deepOrange,
      ),
    );
  }

  static Future showOverlayLoading() {
    return Get.dialog(AlertDialog(
      content: Container(
        height: 50,
        width: 50,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.deepOrange,
          ),
        ),
      ),
    ));
  }

  static Widget customTextButton({
    required String text,
    double? size,
    FontWeight? fontWeight,
    Color? color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.bold,
          letterSpacing: 0,
          color: color ?? Colors.black,
          fontSize: size ?? 14,
        ),
      ),
    );
  }

  static Widget circleButton(
      {double? size, required String iconPath, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: size ?? 30,
        backgroundColor: AppColors.lightGrey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/icon/$iconPath.png'),
        ),
      ),
    );
  }

  static Widget switchButton(
      {required bool value, required Function(bool val) onTap}) {
    return Switch.adaptive(
      value: value,
      onChanged: (val) => onTap(val),
      activeColor: AppColors.orange,
    );
  }

  static Widget addButton({required Function onTap, required double size}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(size),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2, color: AppColors.lightGrey)),
        child: const Icon(Icons.add, color: Colors.grey),
      ),
    );
  }

  static snackBar({required String title,
    required String msg,
    Color? color,
    SnackPosition? snackPosition}) {
    return Get.snackbar(
      title,
      msg,
      backgroundColor: color,
      colorText: color != null ? Colors.white : Colors.black,
      duration: const Duration(seconds: 2),
      snackPosition: snackPosition,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }

  static dottedDivider() {
    return Container(
      decoration: DottedDecoration(
          shape: Shape.line,
          linePosition: LinePosition.bottom,
          color: Colors.grey),
    );
  }

  static httpHandleError({
    required http.Response response,
    required VoidCallback onSuccess,
  }) {
    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 409:
        snackBar(title: jsonDecode(response.body)['status'],
            msg: jsonDecode(response.body)['message']);
        break;
      case 401:
        snackBar(title: jsonDecode(response.body)['status'],
            msg: jsonDecode(response.body)['message']);
        break;
      case 500:
        snackBar(title: jsonDecode(response.body)['status'],
            msg: jsonDecode(response.body)['message']);
        break;
      default:
        snackBar(title: '', msg: response.body);
        log(response.body.toString());
    }
  }
}

const profilePath = 'assets/images/profile.jpg';
