import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class Preview extends StatefulWidget {
  final String? outputVideoPath;

  const Preview(this.outputVideoPath, {Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
      File(widget.outputVideoPath!),
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: true,
      )
    )..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: const Text('Preview'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 9/16,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(child: CircularProgressIndicator()),
        ),
        SizedBox(height: 10.h),
        TextButton(
          child: _isPlaying
              ? const Icon(
            Icons.pause,
            size: 20.0,
            color: Colors.white,
          )
              : const Icon(
            Icons.play_arrow,
            size: 20.0,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isPlaying = !_isPlaying;
              if (_isPlaying) {
                _controller.play();
              } else {
                _controller.pause();
              }
            });
          },
        ),
      ],
    ),
  );
}
