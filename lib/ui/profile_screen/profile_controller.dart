import 'dart:developer';
import 'dart:io';
import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  late TextEditingController firstNameController =
      TextEditingController(text: profileInfo['firstName']);
  late TextEditingController emailController =
      TextEditingController(text: profileInfo['email']);
  late TextEditingController lastNameController =
      TextEditingController(text: profileInfo['lastName']);
  late TextEditingController countryController =
      TextEditingController(text: profileInfo['countryName']);
  late TextEditingController phoneController =
      TextEditingController(text: profileInfo['phoneNumber']);
  RxBool showLoading = false.obs;
  final currentUser = AuthService.firebase().currentUser?.user;
  Map profileInfo = {};
  File? saveImage;

  Future getData() async {
    final data = await AuthService.firebase().getDataFromFireStore();
    if (data.exists) {
      profileInfo.addAll(data.data()!);
    } else {
      log('Something went wrong!');
    }
    update();
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );

      if (image != null) {
        // set Locally

        saveImage = File(image.path);
        refresh();
      } else {
        update();
        Utils.snackBar(title: 'Pick Image', msg: "You don't pick anything");
        return;
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  void clearCachedImages() {
    final cachedNetworkImageProvider = CachedNetworkImageProvider('');
    imageCache.evict(cachedNetworkImageProvider);
  }

  Future updateData() async {
    try {
      showLoading.value = true;
      // set path to for storing image on cloud
      final storageRef = AuthService.firebase().uploadImageOnFirebaseStorage();

      // Check if the user already has an image URL
      final imageUrl = profileInfo['imageUrl'];

      if (imageUrl != null && imageUrl.isNotEmpty) {
        try {
          // Delete the previous image from Firebase Storage
          final previousImageRef = AuthService.firebase()
              .firebaseStorageInstance()
              .refFromURL(imageUrl);
          await previousImageRef.delete();
        } catch (e) {
          // Handle any errors related to deletion
          print("Error deleting previous image: $e");
        }
      }

      //upload image
      await storageRef.putFile(File(saveImage!.path));

      // download image url
      final String downloadImageUrl = await storageRef.getDownloadURL();
      await AuthService.firebase().updateData().then((value) async {
        await value.update(
          {
            'firstName': firstNameController.text,
            'lastName': lastNameController.text,
            'phoneNumber': phoneController.text,
            'countryName': countryController.text,
            'email': emailController.text,
            'imageUrl': downloadImageUrl,
          },
        );
      });

      // uploading Image to AuthAccount
      await currentUser?.updatePhotoURL(downloadImageUrl);

      // clear Images After Upload
      clearCachedImages();

      update();

      if (currentUser?.email != profileInfo['email'])
        await currentUser?.updateEmail(emailController.text);
      showLoading.value = false;
      Get.back();
      Utils.snackBar(title: '', msg: 'Your profile has been updated!');
    } catch (e) {
      showLoading.value = false;
      Get.back();
      log(e.toString());
    }
    ;
  }
}
