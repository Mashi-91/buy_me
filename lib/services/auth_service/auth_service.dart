import 'package:buy_me/services/auth_service/auth_provider.dart';
import 'package:buy_me/services/auth_service/auth_user.dart';
import 'package:buy_me/services/auth_service/firebase_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendForgotPasswordVerification({required String email}) =>
      provider.sendForgotPasswordVerification(email: email);

  @override
  Stream<AuthUser> authStateChanges() => provider.authStateChanges();

  @override
  Future<void> storeDataInFireStore({
    required firstName,
    required lastName,
    required countryName,
    required phoneNumber,
    required wantToBuy,
    required email,
  }) =>
      provider.storeDataInFireStore(
        firstName: firstName,
        lastName: lastName,
        countryName: countryName,
        phoneNumber: phoneNumber,
        wantToBuy: wantToBuy,
        email: email,
      );

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromFireStore() =>
      provider.getDataFromFireStore();

  @override
  Future<DocumentReference<Map<String, dynamic>>> updateData() =>
      provider.updateData();

  @override
  Reference uploadImageOnFirebaseStorage() =>
      provider.uploadImageOnFirebaseStorage();

  @override
  FirebaseStorage firebaseStorageInstance() => provider.firebaseStorageInstance();

}
