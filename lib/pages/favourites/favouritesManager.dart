import 'package:shared_preferences/shared_preferences.dart';

class LikedImagesManager {
  List<String> _likedImages = [];

  static final LikedImagesManager _instance = LikedImagesManager._internal();

  factory LikedImagesManager() {
    return _instance;
  }

  LikedImagesManager._internal();

  Future<void> loadLikedImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _likedImages = prefs.getStringList('liked_images') ?? [];
  }

  List<String> getLikedImages() {
    return _likedImages;
  }

  Future<void> addLikedImage(String imageUrl) async {
    if (!_likedImages.contains(imageUrl)) {
      _likedImages.add(imageUrl);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('liked_images', _likedImages);
    }
  }
}
