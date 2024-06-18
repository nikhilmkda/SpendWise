import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInProvider with ChangeNotifier {

Future<bool> signInWithGoogle() async {
  try {
    // Trigger Google Sign-in flow
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(googleProvider);

    // User signed in successfully
    print("Sign In Successful! User: ${userCredential.user?.email}");
    return true;
  } on FirebaseAuthException catch (error) {
    print("Sign In Failed: ${error.code} - ${error.message}");
    return false; // Or throw an exception for further handling
  } catch (error) {
    print("An unexpected error occurred: $error");
    return false; // Or throw an exception for further handling
  }
}

  
}