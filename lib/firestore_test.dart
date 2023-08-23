import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WallpaperGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('odin').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('No wallpapers found.'),
            );
          }

          final wallpapers = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: wallpapers.length,
            itemBuilder: (BuildContext context, int index) {
              final data = wallpapers[index].data() as Map<String, dynamic>;
              final imageName = data['imageName'] ?? 'Default Name';
              final imageUrl = data['imageUrl'] ??
                  'https://i.pinimg.com/564x/db/cf/7e/dbcf7e18e604987d019981970237774b.jpg';

              return GestureDetector(
                onTap: () {
                  // Handle image tap event
                },
                child: GridTile(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: Text(imageName),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
