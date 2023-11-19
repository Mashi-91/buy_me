import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/const/utils/custom_button.dart';
import 'package:buy_me/models/shoe_model.dart';
import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildHomeShoeCard() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16)
        .copyWith(bottom: 20),
    decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            color: Colors.white60,
            spreadRadius: 0.2,
            blurRadius: 8,
          ),
        ]),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset('assets/images/shoe-1.jpg'),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          width: 290,
          child: Text(
            '20 % OFF ON YOUR CHOICE',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 42,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Use code DTE21 at checked',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 20),
        customButton(
          width: 160,
          textSize: 14,
          title: 'Start Shopping',
          onTap: () {
            final user = AuthService.firebase().currentUser!.user;
            log(user.toString());
          },
          color: Colors.black,
        )
      ],
    ),
  );
}

Widget buildShoeCard(
    {required ShoeModel shoeModel,
    required Function FavButton,
    required bool isFav,
    required Function detailButton}) {
  return InkWell(
    onTap: () => detailButton(),
    child: Stack(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16)
                .copyWith(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              /* boxShadow: const [
              BoxShadow(
                offset: Offset(0,4),
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ]*/
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child:
                      CachedNetworkImage(imageUrl: shoeModel.img, height: 140),
                ),
                const SizedBox(height: 22),
                Text(
                  shoeModel.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  shoeModel.category.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "\$${shoeModel.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            )),
        Positioned(
          right: 20,
          top: 20,
          child: InkWell(
            onTap: () => FavButton(),
            child: Icon(
              !isFav ? Icons.bookmark_border_rounded : Icons.bookmark_outlined,
            ),
          ),
        ),
      ],
    ),
  );
}
