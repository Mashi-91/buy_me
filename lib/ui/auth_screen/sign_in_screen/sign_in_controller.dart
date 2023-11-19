import 'dart:convert';
import 'dart:developer';

import 'package:buy_me/const/const.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/user_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController forgotPasswordController;
  String token = '';
  final signInFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isRemember = false;
  RxBool showLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    forgotPasswordController = TextEditingController();
    // getUserData();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordController.dispose();
  }

  void togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleRemember(bool val) {
    isRemember = val;
    update();
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    showLoading.value = true;

    await AuthService.firebase()
        .logIn(
      email: email,
      password: password,
    )
        .then((value) {
      Get.offAllNamed(Routes.tab_controller_screen);
    });

    // await signInUsingServer(
    //     user: UserModel(id: '', email: email, password: password));

    showLoading.value = false;
  }

  // Future signInUsingServer({required UserModel user}) async {
  //   try{
  //   http.Response response = await http.post(
  //       Uri.parse('${Constants.uri}/users/signIn'),
  //       body: jsonEncode(user.toJson()),
  //       headers: {'Content-Type': 'application/json; charset=UTF-8'});
  //
  //
  //      Utils.httpHandleError(
  //         response: response,
  //         onSuccess: () async {
  //           SharedPreferences prefs = await SharedPreferences.getInstance();
  //           try {
  //             Map<String, dynamic> jsonMap = jsonDecode(response.body);
  //              UserModel.fromJson(jsonMap);
  //           }  catch (e) {
  //             log(e.toString());
  //           }
  //           await prefs.setString(
  //               'x-auth-token', jsonDecode(response.body)['token']);
  //
  //           Get.offAllNamed(Routes.tab_controller_screen);
  //         });
  //   }  catch (e) {
  //     log(e.toString());
  //     showLoading.value = false;
  //   }
  // }

  // Get User Data

  // Future getUserData() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');
  //
  //     if(token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }
  //
  //     var tokenRs = await http.post(
  //         Uri.parse('${Constants.uri}/users/isTokenValid'),
  //         headers: {'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': token!,
  //         });
  //
  //
  //     var response = jsonDecode(tokenRs.body);
  //
  //     if(response) {
  //       http.Response userRes = await http.get(
  //           Uri.parse('${Constants.uri}/users/'),
  //           headers: {'Content-Type': 'application/json; charset=UTF-8',
  //             'x-auth-token': token,
  //           });
  //       token = userRes.body;
  //       return userRes.body;
  //     }
  //   }  catch (e) {
  //     log(e.toString());
  //     return null;
  //   }
  //   // return '';
  // }

  // Future signOut() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('x-auth-token', '');
  //   Future.delayed(Duration(seconds: 2));
  //   Get.offNamedUntil(Routes.authScreen, (route) => false);
  // }



  Future<void> sendPasswordLinkViaEmail() async {
    await AuthService.firebase()
        .sendForgotPasswordVerification(email: forgotPasswordController.text)
        .then((value) => Get.back());
  }
}
