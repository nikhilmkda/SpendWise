import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/sign_in/controller/sign_in_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({Key? key}) : super(key: key);

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Google SignIn Screen')),
        body: Consumer<SignInProvider>(builder: (context, value, child) {
          return Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                iconSize: 40,
                icon: Image.network(
                  "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                ),
                onPressed: () async {
                  bool success = await value.signInWithGoogle();

                  if (success) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
            ),
          );
        }));
  }
}
