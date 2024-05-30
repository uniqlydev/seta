import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/FirebaseUser.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  /// create user
  Future<Usermodel?> signUpUser(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return Usermodel(
          ID: firebaseUser.uid,
          Name: firebaseUser.displayName,
          Email: firebaseUser.email,
          Password: firebaseUser.email,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  } 

   ///signOutUser 
   Future<void> signOutUser() async {
      final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
  // ... (other methods)}
}