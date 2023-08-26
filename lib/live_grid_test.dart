import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class VideoModel {
  final String videoUrl;

  VideoModel({required this.videoUrl});
}

class VideoGridScreen extends StatefulWidget {
  @override
  _VideoGridScreenState createState() => _VideoGridScreenState();
}

class _VideoGridScreenState extends State<VideoGridScreen> {
  List<VideoModel> videos = []; // Initialize an empty list initially

  @override
  void initState() {
    super.initState();
    _fetchVideosFromFirebase();
  }

  Future<void> _fetchVideosFromFirebase() async {
    final storageRef = storage.FirebaseStorage.instance
        .ref('live'); // Reference to the 'videos' folder in Firebase Storage

    final ListResult result =
        await storageRef.listAll(); // List all files in the folder

    setState(() {
      videos = result.items.map((ref) {
        return VideoModel(
            videoUrl: ref.fullPath); // Store the full path as the URL
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF131321),
        title: Text('Live Wall Test'),
      ),
      backgroundColor: Color(0xFF131321),
      body: videos.isEmpty // Check if videos list is empty
          ? CircularProgressIndicator() // Show loading indicator while fetching
          : GridView.builder(
              itemCount: videos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayerScreen(videoUrl: videos[index].videoUrl),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text('Video ${index + 1}'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: VideoPlayerWidget(videoUrl),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget(this.videoUrl);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isLoading = true; // To track whether video loading is complete

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    final videoStorageRef =
        storage.FirebaseStorage.instance.ref(widget.videoUrl);
    final videoUrl = await videoStorageRef.getDownloadURL();

    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isLoading = false; // Video loading is complete
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator() // Show loading indicator while initializing video
        : _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(); // You can replace this with a loading indicator
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
