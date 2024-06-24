import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthRepository {
  final FirebaseAuth _firebaseAuth; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  


  Future<String?> getUserType(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc['userType'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

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

  Future<User?> signInWithUsernameAndPassword({required String username, required String password}) async {
    try {
      // Fetch the user document from Firestore based on the provided username
      final userQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // If user with provided username exists, sign in with their email and password
        final userDoc = userQuery.docs.first;
        final email = userDoc['email'];
        final UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential.user;
      } else {
        // If user with provided username doesn't exist, return null
        return null;
      }
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