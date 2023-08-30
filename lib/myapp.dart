import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luca_ui/pages/util/homepage.dart';
import 'package:luca_ui/pages/util/live_category.dart';
import 'package:luca_ui/pages/util/wallpapers.dart';
import 'package:luca_ui/themes/themes.dart';
import 'pages/util/live.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final colour = Colors.white;
  final List<Widget> _pages = [
    const MyHomePage(
      title: 'Luca Home',
    ),
    const Category(
      title: 'Category',
    ),
    const LiveWallCategory(),
    // FavouritePage(),
    // LiveWallpaperPage(),
    LiveWallpaperPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Luca',
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: SizedBox(
          height: 62,
          child: FlashyTabBar(
            backgroundColor: const Color(0xFF131321),
            animationCurve: Curves.linear,
            selectedIndex: _selectedIndex,
            iconSize: 22,
            // showElevation: false,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            items: [
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.home_outlined),
                title: const Text('Home'),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.wallpaper_outlined),
                title: const Text('Wallpapers'),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.video_collection_outlined),
                title: const Text('Live'),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.favorite_outline),
                title: const Text('Favourites'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
