import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customButton(
    {required String title,
    double? height,
    double? width,
    double? textSize,
    Widget? icon,
    double? borderRadius,
    Color? textColor = Colors.white,
    Color color = Colors.deepOrange,
    required Function onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(borderRadius ?? 26),
    onTap: () => onTap(),
    child: Container(
      alignment: Alignment.center,
      height: height ?? 50,
      width: width ?? 340,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius ??26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: textSize ?? 16,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customCartStepperButton(
    {required Function incrementTap,
    required Function decrementTap,
    required int text}) {
  return Row(
    children: [
      InkWell(
        onTap: () => decrementTap(),
        child: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.remove,
            size: 20,
          ),
        ),
      ),
      SizedBox(
        width: Get.width * 0.04,
      ),
      Text(
        text.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.firaCode().fontFamily),
      ),
      SizedBox(
        width: Get.width * 0.04,
      ),
      InkWell(
        onTap: () => incrementTap(),
        child: const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}

Widget customOutlineButton(
    {required String title,
    double? height,
    double? width,
    double? textSize,
    double? borderWidth,
    Color? borderColor,
    required Function onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(26),
    onTap: () => onTap(),
    child: Container(
      alignment: Alignment.center,
      height: height ?? 50,
      width: width ?? 340,
      decoration: BoxDecoration(
        border: Border.all(
            width: borderWidth ?? 1.0, color: borderColor ?? Colors.grey),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: textSize ?? 16,
        ),
      ),
    ),
  );
}



