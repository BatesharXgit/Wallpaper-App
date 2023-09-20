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
          return ListView.builder(
            itemCount: favoriteImages.length,
            itemBuilder: (context, index) {
              return Image.network(favoriteImages[index]);
            },
          );
        },
      ),
    );
  }
}


// }
