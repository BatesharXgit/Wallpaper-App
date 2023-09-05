import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final Set<String> favoriteCategories;

  FavoritesPage(this.favoriteCategories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Categories'),
      ),
      body: ListView(
        children: favoriteCategories
            .map((category) => ListTile(
                  title: Text(category),
                ))
            .toList(),
      ),
    );
  }
}
