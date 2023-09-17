import 'package:flutter/material.dart';
import 'package:luca_ui/components/square_tile.dart';
import 'package:luca_ui/authentication/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  // final Function()? onTap;
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131321),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

              // const SizedBox(height: 25),

              // username textfield

              // const SizedBox(height: 10),

              // password textfield

              // const SizedBox(height: 10),

              // forgot password?

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.035),

              // not a member? register now
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By Continuing, you agree with Luca',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFFE6EDFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
