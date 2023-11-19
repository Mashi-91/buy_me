import 'dart:developer';

import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:buy_me/services/auth_service/auth_user.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_screen.dart';
import 'package:buy_me/ui/home/tab_controller_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SignInController());
    final stream = FirebaseAuth.instance.authStateChanges();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.deepOrange),
          );
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return const TabControllerScreen();
        }
        return const SignInScreen();
      },
    );
  }
}