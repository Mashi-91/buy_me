import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final User user;

  const AuthUser(this.user);

  factory AuthUser.fromFirebase(User user) => AuthUser(user);
}
