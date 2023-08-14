import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:luca_ui/pages/util/homepage.dart';
import 'package:luca_ui/pages/util/live.dart';
import 'package:luca_ui/pages/util/live_category.dart';
import 'package:luca_ui/pages/util/wallpapers.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp(
    title: ' ',
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});
  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final colour = Colors.white;
  final List<Widget> _pages = [
    const HomePage(
      title: 'Luca Home',
    ),
    const Category(
      title: 'Category',
    ),
    LiveWallCategory(),
    // LiveWallpaperPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Luca',
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GNav(
                tabBorderRadius: 20,
                tabActiveBorder: Border.all(width: 2, color: Color(0xB700FF00)),
                gap: 5,
                curve: Curves.easeInOutQuint, //bounceIn
                haptic: false,
                iconSize: 24,
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(milliseconds: 200),
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                  ),
                  GButton(
                    icon: Icons.wallpaper,
                  ),
                  GButton(
                    icon: Icons.slideshow_outlined,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
