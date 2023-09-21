import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset('lib/images/luca.png'),
                ),
              ),
              Center(
                child: Text(
                  'LUCA',
                  style: TextStyle(
                    fontFamily: 'Anurati',
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.center,
                child: Text(
                  ('"Step into a World of Wall Artistry: \n       Your Screens, Our Canvas!"'),
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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
                  const SizedBox(
                    height: 10,
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
