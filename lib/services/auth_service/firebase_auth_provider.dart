import 'dart:developer';

import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/firebase_options.dart';
import 'package:buy_me/models/profile_model.dart';
import 'package:buy_me/services/auth_service/auth_exceptions.dart';
import 'package:buy_me/services/auth_service/auth_provider.dart';
import 'package:buy_me/services/auth_service/auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        Utils.snackBar(
          title: '',
          msg: 'Account has been created!',
          snackPosition: SnackPosition.BOTTOM,
        );
        return user;
      } else {
        Utils.snackBar(
          title: '',
          msg: 'Something got Wrong!',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw GenericAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Utils.snackBar(
          title: '',
          msg: 'Week Password!',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw WeekPasswordAuthException();
      } else if (e.code == "email-already-in-use") {
        Utils.snackBar(
          title: '',
          msg: 'Email Already Exist!.',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == "invalid-email") {
        Utils.snackBar(
          title: '',
          msg: 'Enter a valid email',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw InvalidEmailAuthException();
      } else {
        Utils.snackBar(
          title: '',
          msg: 'Something got Wrong $e',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        Utils.snackBar(
          title: '',
          msg: 'Something got Wrong!',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw GenericAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.snackBar(
          title: '',
          msg: 'No user found with this email!',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw UserNotFoundAuthException();
      } else if (e.code == "wrong-password") {
        Utils.snackBar(
          title: '',
          msg: 'Your credentials is not Correct!',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw WrongPasswordAuthException();
      } else if (e.code == "invalid-email") {
        Utils.snackBar(
          title: '',
          msg: 'Enter a valid email',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw InvalidEmailAuthException();
      } else {
        Utils.snackBar(
          title: '',
          msg: 'Something got Wrong $e',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendForgotPasswordVerification({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Utils.snackBar(
        title: 'Send Password Link',
        msg:
            'Password reset link has been sent to your registered email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        Utils.snackBar(
          title: '',
          msg: 'Enter a valid email',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw InvalidEmailAuthException();
      } else if (e.code == "auth/user-not-found") {
        Utils.snackBar(
          title: '',
          msg: 'No user found with this email!',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw UserNotFoundAuthException();
      } else {
        // Handle other FirebaseAuthException cases or generic errors here
        Utils.snackBar(
          title: '',
          msg: 'Something went wrong: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
        );
        throw GenericAuthException();
      }
    } catch (e) {
      // Handle generic exceptions here
      Utils.snackBar(
        title: '',
        msg: 'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      throw GenericAuthException();
    }
  }

  @override
  Stream<AuthUser> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges().map((user) {
      return AuthUser.fromFirebase(user!);
    });
  }

  @override
  Future<void> storeDataInFireStore(
      {required firstName,
      required lastName,
      required countryName,
      required phoneNumber,
      required email,
      required wantToBuy}) async {
    try {
      await FirebaseFirestore.instance
          .doc('profileInfo/${currentUser!.user.uid}')
          .set(
            ProfileModel(
              firstName: firstName,
              lastName: lastName,
              countryName: countryName,
              phoneNumber: phoneNumber,
              wantToBuy: wantToBuy,
            ).toJson(),
          )
          .then((value) {
        FirebaseAuth.instance.currentUser!
            .updateDisplayName('$firstName $lastName');
        Utils.snackBar(title: '', msg: 'Your Profile has been uploaded!');
      });
    } on FirebaseFirestore catch (e) {
      log('Something is Wrong $e');
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromFireStore() async {
    const docName = 'profileInfo';
    try {
      final data = await FirebaseFirestore.instance
          .doc('$docName/${currentUser?.user.uid}')
          .get();
      return data;
    } on FirebaseFirestore catch (e) {
      Utils.snackBar(title: '', msg: 'FireStore error! $e');
      throw GetDataErrorException();
    }
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> updateData() async {
    try {
      const docName = 'profileInfo';
      final ref = await FirebaseFirestore.instance
          .doc('$docName/${currentUser?.user.uid}');
      return ref;
    } catch (e) {
      return Utils.snackBar(
          title: '', msg: 'FireStore error while getting data! $e');
    }
    ;
  }

  @override
  Reference uploadImageOnFirebaseStorage() {
    try {
      final storage = FirebaseStorage.instance;

      // set path to for storing image on cloud
      return storage.ref().child(
          'profile_images/${currentUser!.user.uid}/${DateTime.now()}.jpg');
    } catch (e) {
      return Utils.snackBar(
          title: '', msg: 'FireStorage error! $e');
    }
  }

  @override
  FirebaseStorage firebaseStorageInstance() {
    return FirebaseStorage.instance;
  }
}
