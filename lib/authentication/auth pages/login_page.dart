import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luca_ui/components/my_button.dart';
import 'package:luca_ui/components/square_tile.dart';
import 'package:luca_ui/authentication/services/auth_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131321),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              SizedBox(
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  // child: Image.asset('assets/images/logo.png'),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield

              const SizedBox(height: 10),

              // password textfield

              const SizedBox(height: 10),

              // forgot password?

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[200],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),

                  const SizedBox(width: 25),

                  // apple button
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I agree with Luca',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Color(0xFFFE5163),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
