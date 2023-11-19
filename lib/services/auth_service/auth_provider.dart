import 'package:buy_me/services/auth_service/auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;


  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Stream<AuthUser> authStateChanges();

  Future<void> sendForgotPasswordVerification({required String email});

  Future<void> storeDataInFireStore({
    required firstName,
    required lastName,
    required countryName,
    required phoneNumber,
    required wantToBuy,
    required email,
  });

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromFireStore();

  Future<DocumentReference<Map<String, dynamic>>> updateData();

  Reference uploadImageOnFirebaseStorage();

  FirebaseStorage firebaseStorageInstance();
}
