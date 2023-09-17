import 'dart:ui';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> applyHomescreen(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to home screen...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: widget.imageUrl,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: false,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set Successfully 😊',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to set wallpaper',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      Fluttertoast.showToast(
        msg: 'Failed to set wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> applyLockscreen(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to lock screen...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: widget.imageUrl,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: false,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set Successfully 😊',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to set wallpaper',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      Fluttertoast.showToast(
        msg: 'Failed to set wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> applyBoth(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to both screens...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: widget.imageUrl,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: false,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set Successfully 😊',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to set wallpaper',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      Fluttertoast.showToast(
        msg: 'Failed to set wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  bool isWidgetsVisible = true;

  void toggleWidgetsVisibility() {
    setState(() {
      isWidgetsVisible = !isWidgetsVisible;
    });
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: isWidgetsVisible ? 1.0 : 0.0,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isWidgetsVisible ? 1.0 : 0.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isWidgetsVisible ? 1.0 : 0.0,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Home Screen',
                                style: GoogleFonts.kanit(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isWidgetsVisible ? 1.0 : 0.0,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Lock Screen',
                                style: GoogleFonts.kanit(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isWidgetsVisible ? 1.0 : 0.0,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Both Screen',
                                style: GoogleFonts.kanit(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimationLimiter(
        child: Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: toggleWidgetsVisibility,
                child: Hero(
                  tag: widget.imageUrl,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isWidgetsVisible ? 1.0 : 0.0,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      right: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Iconsax.close_circle,
                          color: Theme.of(context).iconTheme.color,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isWidgetsVisible,
                child: Positioned(
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).padding.bottom + 10,
                  child: GestureDetector(
                    onTap: openDialog,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isWidgetsVisible ? 1.0 : 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Iconsax.heart,
                                color: Theme.of(context).iconTheme.color,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isWidgetsVisible ? 1.0 : 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.download,
                                color: Theme.of(context).iconTheme.color,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isWidgetsVisible ? 1.0 : 0.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Apply Wallpaper',
                                    style: GoogleFonts.kanit(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
