import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

class LiveWallpaperPage extends StatefulWidget {
  @override
  _LiveWallpaperPageState createState() => _LiveWallpaperPageState();
}

class _LiveWallpaperPageState extends State<LiveWallpaperPage>
    with AutomaticKeepAliveClientMixin<LiveWallpaperPage> {
  PageController _pageController = PageController();
  List<String> videoUrls = [
    // 'gs://luca-1cfb7.appspot.com/live/Pinterest_Download.mp4',
    'gs://luca-1cfb7.appspot.com/live/3.mp4',
    'gs://luca-1cfb7.appspot.com/live/7.mp4',
    'gs://luca-1cfb7.appspot.com/live/6.mp4',
    'gs://luca-1cfb7.appspot.com/live/8.mp4',
    'gs://luca-1cfb7.appspot.com/live/5.mp4',
    'gs://luca-1cfb7.appspot.com/live/4.mp4',
  ];
  int _currentVideoIndex = 0;
  VideoPlayerController? _controller;
  bool _isPlaying = true;
  bool _videoInitialized = false; // Track if the video player is initialized.

  @override
  void initState() {
    super.initState();
    _initializeVideoController(_currentVideoIndex);
    _pageController.addListener(_onPageChange);
  }

  void _initializeVideoController(int index) async {
    _controller?.dispose();
    final videoUrl = await _getVideoUrl(index);

    // Check if the video is already cached
    final cachedVideo = await DefaultCacheManager().getFileFromCache(videoUrl);

    if (cachedVideo != null && cachedVideo.file.existsSync()) {
      // Video is already cached, load it from the local file path
      _controller = VideoPlayerController.file(cachedVideo.file)
        ..initialize().then((_) {
          setState(() {
            _videoInitialized = true;
          });
          _controller!.play();
          _controller!.setLooping(true);
          _isPlaying = true;
        });
    } else {
      // Video is not cached, download and cache it first
      var file = await DefaultCacheManager().getSingleFile(videoUrl);
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            _videoInitialized = true;
          });
          _controller!.play();
          _controller!.setLooping(true);
          _isPlaying = true;
        });
    }

    _controller!.addListener(_onVideoStateChange);
  }

  Future<String> _getVideoUrl(int index) async {
    // Fetch the video URL from Firebase Storage based on the videoUrls list.
    final ref = FirebaseStorage.instance.refFromURL(videoUrls[index]);
    final url = await ref.getDownloadURL();
    return url;
  }

  void _onVideoStateChange() {
    if (_controller!.value.isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }

  void _onPageChange() {
    int newPageIndex = _pageController.page!.toInt();
    if (newPageIndex != _currentVideoIndex &&
        newPageIndex >= 0 &&
        newPageIndex < videoUrls.length) {
      setState(() {
        _currentVideoIndex = newPageIndex;
        _videoInitialized = false; // Reset the video initialization status.
      });
      _initializeVideoController(newPageIndex);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoStateChange);
    _controller?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> applyLiveWallpaper(String videoUrl) async {
    String result;
    try {
      // Convert Firebase URL to HTTP URL
      final httpUrl = await _getVideoUrl(_currentVideoIndex);

      var file = await DefaultCacheManager().getSingleFile(httpUrl);
      await _controller
          ?.pause(); // Pause the video before setting the wallpaper.
      result = await AsyncWallpaper.setLiveWallpaper(
        filePath: file.path,
      )
          ? 'Live wallpaper set'
          : 'Failed to set live wallpaper.';
    } catch (e) {
      print('Error applying live wallpaper: $e');
      result = 'Failed to set live wallpaper.';
    }
    print(result); // You can handle the result as per your requirement
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            child: PageView.builder(
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padEnds: false,
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                return Center(
                  child: _videoInitialized
                      ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: Visibility(
                            visible: index == _currentVideoIndex,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                      : CircularProgressIndicator(), // Show loading indicator while video is being initialized.
                );
              },
            ),
            onTap: () {
              setState(() {
                _isPlaying = !_isPlaying;
                _isPlaying ? _controller!.play() : _controller!.pause();
              });
            },
          ),
          if (!_isPlaying && _videoInitialized)
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 48,
                ),
                onPressed: () {
                  setState(() {
                    _isPlaying = true;
                    _controller!.play();
                  });
                },
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                if (_videoInitialized) {
                  await applyLiveWallpaper(videoUrls[_currentVideoIndex]);
                  setState(() {
                    _isPlaying = true;
                    _controller!.play();
                  });
                }
              },
              child: Text('Apply wallpaper'),
            ),
          ),
        ],
      ),
    );
  }
}
