import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wallpaper {
  final String imageUrl;
  final String imageName;

  Wallpaper({required this.imageUrl, required this.imageName});
}

class FireStoreTest extends StatefulWidget {
  const FireStoreTest({Key? key}) : super(key: key);

  @override
  State<FireStoreTest> createState() => _FireStoreTestState();
}

class _FireStoreTestState extends State<FireStoreTest> {
  Future<List<Wallpaper>> fetchWallpapers() async {
    final DocumentSnapshot<Map<String, dynamic>> wallpapersDoc =
        await FirebaseFirestore.instance
            .collection('odin')
            .doc('wallpapers')
            .get();
    print('Fetched data: ${wallpapersDoc.data()}');

    final List<dynamic>? wallpaperMaps =
        wallpapersDoc.data()?['wallpapers'] as List<dynamic>?;

    if (wallpaperMaps == null) {
      return [];
    }

    final List<Wallpaper> wallpapers = wallpaperMaps
        .map((map) => Wallpaper(
            imageUrl: map['imageUrl'] as String,
            imageName: map['imageName'] as String))
        .toList();

    return wallpapers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wallpaper App")),
      body: FutureBuilder<List<Wallpaper>>(
        future: fetchWallpapers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error fetching data: ${snapshot.error}');
            return Center(child: Text('Error fetching data.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No wallpapers available.'));
          } else {
            List<Wallpaper> wallpapers = snapshot.data!;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: wallpapers.length,
              itemBuilder: (context, index) {
                Wallpaper wallpaper = wallpapers[index];
                return Column(
                  children: [
                    Image.network(wallpaper.imageUrl),
                    Text(wallpaper.imageName),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
