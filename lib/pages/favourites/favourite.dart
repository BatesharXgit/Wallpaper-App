import 'package:flutter/material.dart';
import 'package:luca_ui/pages/favourites/favouritesManager.dart';
import 'package:provider/provider.dart';

class FavoriteImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Images'),
      ),
      body: Consumer<FavoriteImagesProvider>(
        builder: (context, provider, child) {
          final favoriteImages = provider.favoriteImages;
          print('Favorite Images: $favoriteImages'); // Add this line
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
            ),
            itemCount: favoriteImages.length,
            itemBuilder: (context, index) {
              return Image.network(
                favoriteImages[index],
                fit: BoxFit.cover, 
                errorBuilder: (context, error, stackTrace) {
                  return Text('Failed to load image');
                },
              );
            },
          );
        },
      ),
    );
  }
}
