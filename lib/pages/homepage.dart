import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luca_ui/pages/util/parallax.dart';
import 'package:luca_ui/pages/util/searchresult.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:luca_ui/pages/settings.dart';
import 'package:flutter/rendering.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final Reference wallpaperRef = storage.ref().child('wallpaper');
final Reference abstractRef = storage.ref().child('abstract');
final Reference carsRef = storage.ref().child('cars');
final Reference illustrationRef = storage.ref().child('illustration');

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Reference> wallpaperRefs = [];
  List<Reference> carsRefs = [];
  List<Reference> abstractRefs = [];
  List<Reference> illustrationRefs = [];

  int index = 0;
  final List<String> data = [
    "For You",
    "AI",
    "Illustration",
    "Cars",
    "Abstract",
    "Fantasy",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: data.length, vsync: this);
    loadWallpaperImages();
    loadCarsImages();
    loadAbstractImages();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadWallpaperImages() async {
    final ListResult result = await wallpaperRef.listAll();
    wallpaperRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadillustrationImages() async {
    final ListResult result = await illustrationRef.listAll();
    illustrationRefs = result.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadCarsImages() async {
    final ListResult carResult = await carsRef.listAll();
    carsRefs = carResult.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadAbstractImages() async {
    final ListResult abstractResult = await abstractRef.listAll();
    abstractRefs = abstractResult.items.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          appBar: null,
          backgroundColor: Theme.of(context).colorScheme.background,
          // backgroundColor: Color(0xFF131321),
          // backgroundColor: Colors.black,
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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Iconsax.setting_2,
                  size: 30,
                ),
                color: Theme.of(context).iconTheme.color,
                onPressed: () =>
                    Get.to(SettingsPage(), transition: Transition.fadeIn),
              );
            },
          ),
          Builder(builder: (context) {
            return Expanded(
              child: Center(
                child: Text(
                  'LUCA',
                  style: TextStyle(
                    fontFamily: 'Anurati',
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 30,
                  ),
                ),
              ),
            );
          }),
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () => Get.to(
                  SearchWallpaper(
                    title: '',
                  ),
                  transition: Transition.fadeIn,
                ),
                child: Icon(
                  Iconsax.search_normal_1,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.transparent,
          border:
              Border(bottom: BorderSide(color: Colors.transparent, width: 0)),
        ),
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Theme.of(context).colorScheme.secondary,
        isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        tabs: data.map((tab) {
          return Tab(
            child: Text(
              tab,
              style: GoogleFonts.kanit(
                fontSize: 14,
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

  Widget _buildImageGridFromRef(Reference imageRef) {
    return FutureBuilder<ListResult>(
      future: imageRef.listAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildPlaceholder();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
          List<Reference> imageRefs = snapshot.data!.items;

          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: imageRefs.length,
            itemBuilder: (context, index) {
              final imageRef = imageRefs[index];
              return FutureBuilder<String>(
                future: imageRef.getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }

  Widget _buildTabViews() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildImageGridFromRef(wallpaperRef),
          const Center(
              child: Text("AI", style: TextStyle(color: Colors.white))),
          _buildImageGridFromRef(illustrationRef),
          _buildImageGridFromRef(carsRef),
          _buildImageGridFromRef(abstractRef),
          const Center(
              child: Text("Fantasy", style: TextStyle(color: Colors.white))),
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
            borderRadius: BorderRadius.circular(20),
            child: LocationListItem(
              imageUrl: imageUrl,
              scrollController: scrollController,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: LoadingAnimationWidget.newtonCradle(
        size: 35,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
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
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        size: 35,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> applyHomescreen(BuildContext context) async {
    try {
      showSnackbar(context, 'Applying wallpaper to home screen...');

      bool success = await AsyncWallpaper.setWallpaper(
        url: widget.imageUrl,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: false,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set Successfully 😊',
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
        url: widget.imageUrl,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: false,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set Successfully 😊',
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
        url: widget.imageUrl,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: false,
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (success) {
        Fluttertoast.showToast(
          msg: 'Wallpaper set Successfully 😊',
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
                tag: widget.imageUrl,
                child: Image.network(
                  widget.imageUrl,
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10, left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close_outlined,
                        color: Theme.of(context).iconTheme.color,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    right: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).iconTheme.color,
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
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                    'Apply to Home Screen',
                                    style:
                                        GoogleFonts.kanit(color: Colors.white),
                                  ),
                                  onTap: () {
                                    applyHomescreen(context);
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Apply to Lock Screen',
                                  style: GoogleFonts.kanit(color: Colors.white),
                                ),
                                onTap: () {
                                  applyLockscreen(context);
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Apply to Both',
                                  style: GoogleFonts.kanit(color: Colors.white),
                                ),
                                onTap: () {
                                  applyBoth(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Apply Wallpaper',
                              style: GoogleFonts.kanit(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationListItem extends StatelessWidget {
  LocationListItem({
    Key? key,
    required this.imageUrl,
    required this.scrollController,
  }) : super(key: key);

  final String imageUrl;
  final ScrollController scrollController;

  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _buildParallaxBackground(context);
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
