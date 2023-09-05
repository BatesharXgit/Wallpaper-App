import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      backgroundColor: Color(0xFF131321),
      body: Center(
        child: Text('Favourite',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
}
