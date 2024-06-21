import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider with ChangeNotifier {
  bool isUserSignIn = false;

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isUserSignIn = true;
      notifyListeners();
      return true;
    } on Exception catch (e) {
      isUserSignIn = false;
      print('exception->$e');
      notifyListeners();
      return false;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      isUserSignIn = false;
      notifyListeners();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
