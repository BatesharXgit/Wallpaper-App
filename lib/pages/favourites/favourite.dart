import 'package:flutter/material.dart';

// class FavouritePage extends StatelessWidget {
//   const FavouritePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: null,
//       backgroundColor: Color(0xFF131321),
//       body: Center(
//         child: Text('Favourite',
//             style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white)),
//       ),
//     );
//   }import 'package:flutter/material.dart';

class FavouritesWallpaper extends StatelessWidget {
  final List<String> likedImages;

  const FavouritesWallpaper({Key? key, required this.likedImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Images'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
        ),
        itemCount: likedImages.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    likedImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Liked Image ${index + 1}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// }
