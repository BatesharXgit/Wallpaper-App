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
    'gs://luca-ui.appspot.com/live/urus.mp4',
    'gs://luca-ui.appspot.com/live/dodge.mp4',
    'gs://luca-ui.appspot.com/live/2.mp4',
    'gs://luca-ui.appspot.com/live/3.mp4',
    'gs://luca-ui.appspot.com/live/6.mp4',
    'gs://luca-ui.appspot.com/live/7.mp4',
    'gs://luca-ui.appspot.com/live/8.mp4',
    'gs://luca-ui.appspot.com/live/be67f2ca8a93e96c88ed9415d0f229c6.mp4',
    'gs://luca-ui.appspot.com/live/e114fef3574a6a25f713d14bf8b72f73.mp4',
  ];
  int _currentVideoIndex = 0;
  VideoPlayerController? _controller;
  bool _isPlaying = true;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoController(_currentVideoIndex);
    _pageController.addListener(_onPageChange);
  }

  void _initializeVideoController(int index) async {
    _controller?.dispose();
    final videoUrl = await _getVideoUrl(index);

    final cachedVideo = await DefaultCacheManager().getFileFromCache(videoUrl);

    if (cachedVideo != null && cachedVideo.file.existsSync()) {
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
      await _controller?.pause();
      result = await AsyncWallpaper.setLiveWallpaper(
        filePath: file.path,
      )
          ? 'Live wallpaper set'
          : 'Failed to set live wallpaper.';
    } catch (e) {
      print('Error applying live wallpaper: $e');
      result = 'Failed to set live wallpaper.';
    }
    print(result);
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
                      : CircularProgressIndicator(),
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
