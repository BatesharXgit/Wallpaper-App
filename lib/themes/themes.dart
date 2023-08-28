import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(0xFF131321),
    primary: Colors.white,
    secondary: Colors.grey,
    tertiary: Color(0xFF1E1E2A),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF131321),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Color(0xFF131321),
      secondary: Colors.grey,
      tertiary: Colors.grey[200]),
  iconTheme: IconThemeData(
    color: Color(0xFF131321),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.white),
    unselectedIconTheme: IconThemeData(
      color: Color(0xFF131321),
    ),
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF131321),
    unselectedItemColor: Colors.grey,
  ),
);
