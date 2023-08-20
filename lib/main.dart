import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:luca_ui/pages/util/favourite.dart';
import 'package:luca_ui/pages/util/homepage.dart';
import 'package:luca_ui/pages/util/live.dart';
import 'package:luca_ui/pages/util/live_category.dart';
import 'package:luca_ui/pages/util/wallpapers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

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
    // FavouritePage(),
    LiveWallpaperPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Luca',
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          height: 72,
          child: FlashyTabBar(
            backgroundColor: Color(0xFF131321),
            animationCurve: Curves.linear,
            selectedIndex: _selectedIndex,
            iconSize: 28,
            // showElevation: false,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            items: [
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: Icon(Icons.home_outlined),
                title: Text('Home'),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: Icon(Icons.wallpaper_outlined),
                title: Text('Wallpapers'),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: Icon(Icons.video_collection_outlined),
                title: Text('Live'),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: Icon(Icons.favorite_outline),
                title: Text('Favourites'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
