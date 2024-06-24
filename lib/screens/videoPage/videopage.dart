import 'package:auto_size_text/auto_size_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
      ),
      autoPlay: true,

    );

    // Listen for changes in the video player state
    flickManager.flickVideoManager?.videoPlayerController?.addListener(() {
      setState(() {}); // Update the UI when the video player state changes
    });

    // Initialize the video player
    flickManager.flickVideoManager?.videoPlayerController?.initialize().then((_) {
      setState(() {}); // Ensure the UI is updated once the initialization is complete
      flickManager.flickVideoManager?.videoPlayerController?.play(); // Optionally start playing the video automatically
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video
          flickManager.flickVideoManager?.videoPlayerController?.value.isInitialized ?? false
              ? FlickVideoPlayer(flickManager: flickManager)
              : Center(child: CircularProgressIndicator()),

          // Title of the video, Views and Upload time
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                left: screenWidth * 0.03,
                right: screenWidth * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Tarak Mehta ka Ooltah Chashma Episode - 321',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AutoSizeText(
                    '10M Views - 2 Days ago',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),

          // Channel Photo, Channel Name, Subscriber, Subscribe Button
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.03,
              right: screenWidth * 0.03,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  child: Icon(Remix.user_3_line),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          'Channel Name',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      AutoSizeText(
                        'Subscriber',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  height: screenHeight * 0.045,
                  width: screenWidth * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Subscribe',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
