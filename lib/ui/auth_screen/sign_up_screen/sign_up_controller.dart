import 'dart:convert';
import 'dart:developer';

import 'package:buy_me/const/const.dart';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/profile_model.dart';
import 'package:buy_me/models/user_model.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  // TextEditingController for SignUpScreen
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // TextEditingController for FillScreen
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController countryController;
  late TextEditingController phoneController;
  late TextEditingController questionController;
  final fillFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isTerm = false;
  bool isAgreement = false;
  String agreeError = "";
  RxBool showLoading = false.obs;
  final currentUser = AuthService.firebase().currentUser?.user;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    countryController = TextEditingController();
    phoneController = TextEditingController();
    questionController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    // emailController.dispose();
    // passwordController.dispose();
    // firstNameController.dispose();
    // lastNameController.dispose();
    // countryController.dispose();
    // phoneController.dispose();
    // questionController.dispose();
  }

  void togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleTerm(bool val) {
    isTerm = val;
    isAgreement = val;
    if (isAgreement) {
      agreeError = "";
    } else {
      agreeError = "This field must be checked";
    }
    update();
  }

  Future<void> signUpWithEmailAndPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    showLoading.value = true;
    await AuthService.firebase().createUser(
      email: email,
      password: password,
    );
    // await signUpFromServer(
    //     user: UserModel(id: '', email: email, password: password));
    showLoading.value = false;

    /*currentUser.updatePhoneNumber(PhoneAuthProvider.credential(
      verificationId: 'verificationId',
      smsCode: 'smsCode',
    ));*/
  }

  // Future? signUpFromServer({required UserModel user}) async {
  //   try {
  //     http.Response response = await http.post(
  //         Uri.parse('${Constants.uri}/users/signup'),
  //         body: jsonEncode(user.toJson()),
  //         headers: {'Content-Type': 'application/json; charset=UTF-8'});
  //
  //     Utils.httpHandleError(
  //         response: response,
  //         onSuccess: () {
  //           Utils.snackBar(
  //             title: 'Authorized',
  //             msg: 'Account created! Login with same credentials',
  //             snackPosition: SnackPosition.BOTTOM,
  //           );
  //           Get.offAllNamed(Routes.signUpFillScreen);
  //         });
  //   } catch (e) {
  //     Utils.snackBar(title: 'Error', msg: e.toString());
  //     log(e.toString());
  //     showLoading.value = false;
  //   }
  // }

  Future storeDataInFireStore() async {
    try {
      showLoading.value = true;
      await AuthService.firebase()
          .storeDataInFireStore(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            countryName: countryController.text,
            phoneNumber: phoneController.text,
            wantToBuy: questionController.text,
            email: currentUser?.email.toString(),
          )
          .then((value) => Get.offAllNamed(Routes.tab_controller_screen));
    //   http.Response response = await http.post(
    //     Uri.parse("${Constants.uri}/users/storeData"),
    //     body: jsonEncode(
    //       ProfileModel(
    //         firstName: firstNameController.text,
    //         lastName: lastNameController.text,
    //         countryName: countryController.text,
    //         phoneNumber: phoneController.text,
    //         wantToBuy: questionController.text,
    //       ),
    //     ),
    //     headers: {'Content-Type': 'application/json; charset=UTF-8'},
    //   );
    //
    //   Utils.httpHandleError(response: response, onSuccess: (){
    //     Utils.snackBar(title: 'Success', msg: jsonDecode(response.body)['message']);
    //     Get.offAllNamed(Routes.tab_controller_screen);
    //   });
    //
      showLoading.value = false;
    } on Exception catch (e) {
      log(e.toString());
      showLoading.value = false;
    }
  }
}
