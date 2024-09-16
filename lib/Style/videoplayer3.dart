import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerfromFile extends StatefulWidget {
  String path;

  VideoPlayerfromFile({super.key,required this.path});
  @override
  State<VideoPlayerfromFile> createState() => _VideoPlayerfromFileState();
}

class _VideoPlayerfromFileState extends State<VideoPlayerfromFile> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(File(widget.path)),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
