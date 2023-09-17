import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luca_ui/pages/homepage.dart';
import 'package:luca_ui/pages/util/fullscreen.dart';
import 'package:luca_ui/pages/util/location_list.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final Reference amoledRef = storage.ref().child('wallpaper');
final Reference spaceRef = storage.ref().child('cars');
final Reference stockRef = storage.ref().child('illustration');
final Reference minimalistRef = storage.ref().child('abstract');
final Reference natureRef = storage.ref().child('wallpaper');
final Reference animalsRef = storage.ref().child('wallpaper');
final Reference scifiRef = storage.ref().child('wallpaper');
final Reference gamesRef = storage.ref().child('wallpaper');

ScrollController scrollController = ScrollController();

//=====================================================================================================================
//===============================================  Amoled Wallpaper ===================================================
//=====================================================================================================================
class AmoledWallpaper extends StatefulWidget {
  const AmoledWallpaper({super.key});

  @override
  State<AmoledWallpaper> createState() => _AmoledWallpaperState();
}

class _AmoledWallpaperState extends State<AmoledWallpaper> {
  List<Reference> amoledRefs = [];
  @override
  void initState() {
    super.initState();
    loadamoledImages();
  }

  Future<void> loadamoledImages() async {
    final ListResult result = await amoledRef.listAll();
    amoledRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    // Color secondaryColor = Theme.of(context).colorScheme.secondary;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Amoled',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: amoledRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: amoledRefs.length,
                      itemBuilder: (context, index) {
                        final amoRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: amoRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  Space Wallpaper ===================================================
//=====================================================================================================================
class SpaceWallpaper extends StatefulWidget {
  const SpaceWallpaper({super.key});

  @override
  State<SpaceWallpaper> createState() => _SpaceWallpaperState();
}

class _SpaceWallpaperState extends State<SpaceWallpaper> {
  List<Reference> spaceRefs = [];

  @override
  void initState() {
    super.initState();
    loadspaceImages();
  }

  Future<void> loadspaceImages() async {
    final ListResult result = await spaceRef.listAll();
    spaceRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Space',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: spaceRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: spaceRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  Stock Wallpaper ===================================================
//=====================================================================================================================

class StockWallpapers extends StatefulWidget {
  const StockWallpapers({super.key});

  @override
  State<StockWallpapers> createState() => _StockWallpapersState();
}

class _StockWallpapersState extends State<StockWallpapers> {
  List<Reference> stockRefs = [];

  @override
  void initState() {
    super.initState();
    loadstockImages();
  }

  Future<void> loadstockImages() async {
    final ListResult result = await stockRef.listAll();
    stockRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Stock',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: stockRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: stockRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  Minimalist Wallpaper ===============================================
//=====================================================================================================================
class MinimalistWallpaper extends StatefulWidget {
  const MinimalistWallpaper({super.key});

  @override
  State<MinimalistWallpaper> createState() => _MinimalistWallpaperState();
}

class _MinimalistWallpaperState extends State<MinimalistWallpaper> {
  List<Reference> minimalistRefs = [];

  @override
  void initState() {
    super.initState();
    loadminimalistImages();
  }

  Future<void> loadminimalistImages() async {
    final ListResult result = await minimalistRef.listAll();
    minimalistRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Minimalist',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: minimalistRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: minimalistRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  Nature Wallpaper ===================================================
//=====================================================================================================================

class NatureWallpaper extends StatefulWidget {
  const NatureWallpaper({super.key});

  @override
  State<NatureWallpaper> createState() => _NatureWallpaperState();
}

class _NatureWallpaperState extends State<NatureWallpaper> {
  List<Reference> natureRefs = [];

  @override
  void initState() {
    super.initState();
    loadnatureImages();
  }

  Future<void> loadnatureImages() async {
    final ListResult result = await natureRef.listAll();
    natureRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Nature',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: natureRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: natureRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  Animals Wallpaper ===================================================
//=====================================================================================================================

class AnimalsWallpaper extends StatefulWidget {
  const AnimalsWallpaper({super.key});

  @override
  State<AnimalsWallpaper> createState() => _AnimalsWallpaperState();
}

class _AnimalsWallpaperState extends State<AnimalsWallpaper> {
  List<Reference> animalsRefs = [];

  @override
  void initState() {
    super.initState();
    loadanimalsImages();
  }

  Future<void> loadanimalsImages() async {
    final ListResult result = await animalsRef.listAll();
    animalsRefs = result.items.toList();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Animals',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: animalsRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: animalsRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  SciFi Wallpaper ===================================================
//=====================================================================================================================

class ScifiWallpaper extends StatefulWidget {
  const ScifiWallpaper({super.key});

  @override
  State<ScifiWallpaper> createState() => _ScifiWallpaperState();
}

class _ScifiWallpaperState extends State<ScifiWallpaper> {
  List<Reference> scifiRefs = [];

  @override
  void initState() {
    super.initState();
    loadscifiImages();
  }

  Future<void> loadscifiImages() async {
    final ListResult result = await scifiRef.listAll();
    scifiRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Sci - Fi',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: scifiRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: scifiRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================================================================================================
//===============================================  Games Wallpaper ===================================================
//=====================================================================================================================

class GamesWallpaper extends StatefulWidget {
  const GamesWallpaper({super.key});

  @override
  State<GamesWallpaper> createState() => _GamesWallpaperState();
}

class _GamesWallpaperState extends State<GamesWallpaper> {
  List<Reference> gamesRefs = [];
  @override
  void initState() {
    super.initState();
    loadgamesImages();
  }

  Future<void> loadgamesImages() async {
    final ListResult result = await gamesRef.listAll();
    gamesRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Games',
          style: GoogleFonts.kanit(
            color: primaryColor,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListResult>(
                future: gamesRef.listAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildPlaceholder();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.items.isNotEmpty) {
                    List<Reference> imageRefs = snapshot.data!.items;

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: gamesRefs.length,
                      itemBuilder: (context, index) {
                        final imageRef = imageRefs[index];
                        return FutureBuilder<String>(
                          future: imageRef.getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildCircularIndicator();
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget();
                            } else if (snapshot.hasData) {
                              return _buildImageWidget(snapshot.data!);
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No images available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildImageWidget(String imageUrl) {
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
          ),
        );
      },
      child: Hero(
        tag: imageUrl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LocationListItem(
              imageUrl: imageUrl,
              scrollController: scrollController,
            ),
          ),
        ),
      ),
    );
  });
}

Widget _buildPlaceholder() {
  return Builder(builder: (context) {
    return Center(
      child: LoadingAnimationWidget.newtonCradle(
        size: 35,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  });
}

Widget _buildErrorWidget() {
  return Container(
    color: Colors.transparent,
    child: const Icon(
      Icons.error,
      color: Colors.red,
    ),
  );
}

Widget _buildCircularIndicator() {
  return Builder(builder: (context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        size: 35,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  });
}
