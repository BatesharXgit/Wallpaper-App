import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:luca_ui/pages/util/searchresult.dart';
import 'package:firebase_storage/firebase_storage.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final FirebaseStorage storage = FirebaseStorage.instance;
final Reference wallpaperRef = storage.ref().child('wallpaper');
final Reference carsRef = storage.ref().child('cars');
List<Reference> wallpaperRefs = [];
List<Reference> carsRefs = [];

final List<String> data = [
  "For You",
  "AI",
  "Illustration",
  "Cars",
  "Abstract",
  "Fantasy",
];

int index = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Set<String> imageUrls = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: data.length, vsync: this);
    shuffleImages();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> shuffleImages() async {
    final ListResult result = await wallpaperRef.listAll();
    final ListResult carResult = await carsRef.listAll();
    final List<Reference> shuffledwallpaperrefs = result.items.toList()
      ..shuffle();
    final List<Reference> shuffledcarsrefs = carResult.items.toList()
      ..shuffle();
    if (mounted) {
      setState(() {
        wallpaperRefs = shuffledwallpaperrefs;
        carsRefs = shuffledcarsrefs;
      });
    }
  }

  Future<void> refreshImages() async {
    await shuffleImages();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          appBar: null,
          endDrawer: Drawer(
            elevation: 5,
            backgroundColor: const Color(0xFF131321),
            width: MediaQuery.of(context).size.width * 0.75,
            shadowColor: const Color.fromARGB(255, 213, 122, 140),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: _buildDrawerContent(),
          ),
          // backgroundColor: Color(0xFF131321),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                _buildTabBar(),
                Expanded(
                  child: _buildTabViews(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/eb/ca/00/ebca00a3ab8c347ad89bb0fcf2bac859.jpg'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA6E738).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(4, 6),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Expanded(
            child: Text(
              'LUCA',
              style: TextStyle(
                fontFamily: 'Anurati',
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.to(
                    SearchWallpaper(
                      title: '',
                    ),
                    transition: Transition.fadeIn),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Search for...',
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 119, 7),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
        indicator: null,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
        tabs: data.map((tab) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.046,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              color: Color(0xB700FF00),
              borderRadius: BorderRadius.circular(15),
              // gradient: const LinearGradient(
              //   colors: [
              //     Color(0xFF74A225),
              //     Color(0xFF3F8906),
              //   ],
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              // ),
            ),
            child: Tab(
              child: Text(
                tab,
                style: GoogleFonts.kanit(
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(const Color(0xB700FF00)),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildGridView(List<Reference> items) {
    return GridView.count(
      childAspectRatio: 0.7,
      crossAxisCount: 2,
      children: items.map((item) => _buildGridItem(item)).toList(),
    );
  }

  Widget _buildGridItem(Reference foryouRef) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: const Duration(milliseconds: 375),
      columnCount: 2,
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: FutureBuilder<String>(
            future: foryouRef.getDownloadURL(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildPlaceholder();
              } else if (snapshot.hasError) {
                return _buildErrorWidget();
              } else if (snapshot.hasData) {
                return _buildImageWidget(snapshot.data!);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabViews() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: TabBarView(
        controller: _tabController,
        children: [
          RefreshIndicator(
            backgroundColor: Colors.black,
            color: const Color(0xB700FF00),
            onRefresh: refreshImages,
            child: FutureBuilder<ListResult>(
              future: wallpaperRef.listAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingWidget();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData &&
                    snapshot.data!.items.isNotEmpty) {
                  return _buildGridView(snapshot.data!.items);
                } else {
                  return Center(child: Text('No images available'));
                }
              },
            ),
          ),

          const Center(
            child: Text(
              "AI",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Center(
            child: Text(
              "Illustration",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Center(
            child: Text(
              "Abstract",
              style: TextStyle(color: Colors.white),
            ),
          ),
//======================================================================================================================================
//======================================================================================================================================
//=========================================================  CARS   Wallpaepr ==========================================================
//======================================================================================================================================
          RefreshIndicator(
            backgroundColor: Colors.black,
            color: Color(0xB700FF00),
            onRefresh: refreshImages,
            child: FutureBuilder<ListResult>(
              future: carsRef.listAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xB700FF00)),
                    backgroundColor: Colors.black,
                  ));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData &&
                    snapshot.data!.items.isNotEmpty) {
                  if (carsRefs.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xB700FF00)),
                        backgroundColor: Colors.black,
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data!.items.length,
                    itemBuilder: (context, index) {
                      final foryouRef = carsRefs[index];
                      return FutureBuilder<String>(
                        future: foryouRef.getDownloadURL(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _buildPlaceholder();
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
          const Center(
            child: Text(
              "Nature",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
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
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xB700FF00)), // Set your desired color here
                  backgroundColor: Colors.black,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.black,
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.red,
      child: Icon(Icons.error),
    );
  }

  Widget _buildDrawerContent() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/eb/ca/00/ebca00a3ab8c347ad89bb0fcf2bac859.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Craftive',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          thickness: 2.5,
          color: Colors.white,
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Homepage'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          leading: const Icon(Icons.search_outlined),
          title: const Text('Search'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {},
        ),
        // Get.to(const Category(), transition: Transition.fade)),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Help & Support'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            // Handle Help & Support menu item tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.share_outlined),
          title: const Text('Share and Feedback'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            // Handle Share and Feedback menu item tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.featured_play_list_outlined),
          title: const Text('App Features'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            // Handle App Information menu item tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('App Information'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            // Handle App Information menu item tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app_outlined),
          title: const Text('Exit'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            // Handle Exit menu item tap
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Made with 💚 in India.',
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({Key? key, required this.imageUrl})
      : super(key: key);

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

  Future<void> applyHomescreen(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to home screen...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: imageUrl,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: true,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to set wallpaper',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      Fluttertoast.showToast(
        msg: 'Failed to set wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> applyLockscreen(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to lock screen...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: imageUrl,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: true,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to set wallpaper',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      Fluttertoast.showToast(
        msg: 'Failed to set wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> applyBoth(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to both screens...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: imageUrl,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: true,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to set wallpaper',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      Fluttertoast.showToast(
        msg: 'Failed to set wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimationLimiter(
        child: Center(
          child: Stack(
            children: [
              Hero(
                tag: imageUrl,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10, left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).padding.bottom + 10,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            // Apply the blur effect only to the bottom sheet
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Apply to Home Screen',
                                      style: GoogleFonts.kanit(
                                          color: Colors.white),
                                    ),
                                    onTap: () {
                                      applyHomescreen(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Apply to Lock Screen',
                                      style: GoogleFonts.kanit(
                                          color: Colors.white),
                                    ),
                                    onTap: () {
                                      applyLockscreen(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Apply to Both',
                                      style: GoogleFonts.kanit(
                                          color: Colors.white),
                                    ),
                                    onTap: () {
                                      applyBoth(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(
                              child: Text(
                                'Apply Wallpaper',
                                style: GoogleFonts.kanit(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
