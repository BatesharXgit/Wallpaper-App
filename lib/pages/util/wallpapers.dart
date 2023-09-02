import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final Reference amoledRef = storage.ref().child('wallpaper');
final Reference landscapesRef = storage.ref().child('wallpaper');
final Reference cityscapesRef = storage.ref().child('wallpaper');
final Reference spaceRef = storage.ref().child('wallpaper');
final Reference stockRef = storage.ref().child('wallpaper');
final Reference minimalistRef = storage.ref().child('wallpaper');
final Reference natureRef = storage.ref().child('wallpaper');
final Reference animalsRef = storage.ref().child('wallpaper');
final Reference scifiRef = storage.ref().child('wallpaper');
final Reference gamesRef = storage.ref().child('wallpaper');

class Category extends StatefulWidget {
  const Category({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  List<Reference> amoledRefs = [];
  List<Reference> landscapesRefs = [];
  List<Reference> cityscapesRefs = [];
  List<Reference> spaceRefs = [];
  List<Reference> stockRefs = [];
  List<Reference> minimalistRefs = [];
  List<Reference> natureRefs = [];
  List<Reference> animalsRefs = [];
  List<Reference> scifiRefs = [];
  List<Reference> gamesRefs = [];

  final List<String> categories = [
    'Amoled',
    'Landscapes',
    'Cityscapes',
    'Space',
    'Stock',
    'Minimalist',
    'Nature',
    'Animals',
    'Sci-Fi',
    'Games',
  ];

  @override
  void initState() {
    super.initState();
    loadamoledImages();
    loadlandscapesImages();
    loadcityscapesImages();
    loadspaceImages();
    loadstockImages();
    loadminimalistImages();
    loadnatureImages();
    loadanimalsmages();
    loadscifiImages();
    loadgamesImages();
  }

  Future<void> loadamoledImages() async {
    final ListResult result = await amoledRef.listAll();
    amoledRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadlandscapesImages() async {
    final ListResult result = await landscapesRef.listAll();
    landscapesRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadcityscapesImages() async {
    final ListResult result = await cityscapesRef.listAll();
    cityscapesRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadspaceImages() async {
    final ListResult result = await spaceRef.listAll();
    spaceRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadstockImages() async {
    final ListResult result = await stockRef.listAll();
    stockRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadminimalistImages() async {
    final ListResult result = await minimalistRef.listAll();
    minimalistRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadnatureImages() async {
    final ListResult result = await natureRef.listAll();
    natureRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadanimalsmages() async {
    final ListResult result = await animalsRef.listAll();
    animalsRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadscifiImages() async {
    final ListResult result = await scifiRef.listAll();
    scifiRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadgamesImages() async {
    final ListResult result = await gamesRef.listAll();
    gamesRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  bool showAllImages = false;

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
          'Categories',
          style: GoogleFonts.orbitron(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amoled",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Landscapes",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cityscapes",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Space",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stock",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Minimalist",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nature",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Animals",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sci-Fi",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Games",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllImages = !showAllImages;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: min(8, amoledRefs.length),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final imageRef = amoledRefs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String>(
                            future: imageRef.getDownloadURL(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildCircularIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text('No Data');
                              }

                              return Image.network(
                                snapshot.data.toString(),
                                width: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularIndicator() {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        size: 35,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
