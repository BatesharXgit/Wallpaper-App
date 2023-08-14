import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LiveWallpaperPage extends StatefulWidget {
  @override
  _LiveWallpaperPageState createState() => _LiveWallpaperPageState();
}

class _LiveWallpaperPageState extends State<LiveWallpaperPage>
    with AutomaticKeepAliveClientMixin<LiveWallpaperPage> {
  PageController _pageController = PageController();
  List<String> videoUrls = [
    'gs://luca-1cfb7.appspot.com/live/Pinterest_Download.mp4',
    'gs://luca-1cfb7.appspot.com/live/7.mp4',
    'gs://luca-1cfb7.appspot.com/live/6.mp4',
    'gs://luca-1cfb7.appspot.com/live/5.mp4',
    'gs://luca-1cfb7.appspot.com/live/4.mp4'
  ];
  int _currentVideoIndex = 0;
  VideoPlayerController? _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoController(_currentVideoIndex);
    _pageController.addListener(_onPageChange);
  }

  void _initializeVideoController(int index) async {
    _controller?.dispose();
    final videoUrl = await _getVideoUrl(index);
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
        _controller!.setLooping(true);
        _isPlaying = true;
      });

    _controller!.addListener(_onVideoStateChange);
  }

  Future<String> _getVideoUrl(int index) async {
    // Fetch the video URL from Firebase Storage based on the videoUrls list.
    final videoRef = FirebaseStorage.instance.refFromURL(videoUrls[index]);
    final url = await videoRef.getDownloadURL();
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
                  child: _controller!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: Visibility(
                            visible: index == _currentVideoIndex,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                      : Container(),
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
          if (!_isPlaying)
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
        ],
      ),
    );
  }
}
