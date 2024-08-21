import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      // Automatically play the video when the controller is initialized
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});  // Trigger a rebuild after the video is initialized
    });
  }

  @override
  void dispose() {
    // Ensure the video controller is disposed when the widget is disposed
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the video is ready, display it
          return AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
          );
        } else {
          // Otherwise, display a loading indicator
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
