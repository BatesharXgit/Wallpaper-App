import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luca_ui/myapp.dart';
import 'package:luca_ui/authentication/auth%20pages/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage(
                title: 'Inspirio',
              );
            } else {
              return const LoginOrRegisterPage();
            }
          }),
    );
  }
}