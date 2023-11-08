import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:receiver/src/core/resources/app_constant.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: GoogleAuthButton(
          onPressed: () async {
            final GoogleSignInAccount? googleUser =
                await GoogleSignIn().signIn();

            if (googleUser == null) {
              return;
            }

            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;

            final OAuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            await FirebaseAuth.instance.signInWithCredential(credential);

            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.home,
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
