import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveWallCategory extends StatefulWidget {
  const LiveWallCategory({super.key});

  @override
  State<LiveWallCategory> createState() => _LiveWallCategoryState();
}

class _LiveWallCategoryState extends State<LiveWallCategory> {
  final List<String> categories = [
    'Cars',
    'Anime',
    'Nature',
    'CyberWorld',
    'Games',
    'Fantasy',
    'Landscape',
    'Cityscapes',
    'Abstract',
    'Aquatic',
    'Space',
    'Technology',
    'Animals',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  'Live Wallpapers',
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 24, 24, 24),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(color: Colors.white),
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
    );
  }
}
