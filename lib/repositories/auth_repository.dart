import 'package:firebase_auth/firebase_auth.dart';


class AuthRepository {
  final FirebaseAuth _firebaseAuth; 

  AuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signInWithEmailandPassword({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUpWithEmailandPassword({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }
}