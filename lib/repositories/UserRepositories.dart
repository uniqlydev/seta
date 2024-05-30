import 'package:codingbryant/models/FirebaseUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepostory {
  final FirebaseAuth _firebaseAuth;

  UserRepostory({required FirebaseAuth firebaseAuth}) 
    : _firebaseAuth = firebaseAuth;

  Future<void> signinWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<FireBaseUser> getUser() async {
    final currentUser = await _firebaseAuth.currentUser;
    return FireBaseUser(uid: currentUser!.uid, email: currentUser.email!);
  }


}