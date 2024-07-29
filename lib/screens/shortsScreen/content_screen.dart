import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContentScreen extends StatefulWidget {
  final Map<String, dynamic> videoData;


  const ContentScreen({Key? key, required this.videoData}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool _isSubscribed = false;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late ValueNotifier<double> _sliderValueNotifier;

  @override
  void initState() {
    super.initState();
    _sliderValueNotifier = ValueNotifier(0.0);
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoData['url']);
    // _videoPlayerController.setVolume(1.0);
    await Future.wait([_videoPlayerController.initialize()]);
    final video = YoutubePlayer.convertUrlToId(widget.videoData['url']);
    YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: video!,

        flags: YoutubePlayerFlags(
            autoPlay: false,
            hideControls: false,
            hideThumbnail: true
        ),

        // initialVideoId: YoutubePlayer.convertUrlToId(videoUrl!) ?? '',
        //     flags: YoutubePlayerFlags(
        //       autoPlay: true,
        //       hideThumbnail: true,
        //       controlsVisibleAtStart: true,
        //       hideControls: false
        //     ),
        //
        //   ),
        // showVideoProgressIndicator: true,
        // progressIndicatorColor: Colors.amber,
        // progressColors: const ProgressBarColors(
        //   playedColor: Colors.amber,
        //   handleColor: Colors.amberAccent,
      ),
      showVideoProgressIndicator: true,
      onReady: () => debugPrint('Ready'),
      bottomActions: [
        CurrentPosition(),
        ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red
            )
        )
      ],

    );

    
    
    // _chewieController = ChewieController(
      // videoPlayerController: _videoPlayerController,
      // autoInitialize: true,
      // autoPlay: true,
      // showControls: false,
      // looping: true,
      // draggableProgressBar: true,
    // );
    
    // _videoPlayerController.addListener(() {
    //   if (_videoPlayerController.value.isInitialized) {
    //     final duration = _videoPlayerController.value.duration;
    //     final position = _videoPlayerController.value.position;
    //     final progress = duration.inMilliseconds > 0
    //         ? position.inMilliseconds / duration.inMilliseconds
    //         : 0.0;
    //     _sliderValueNotifier.value = progress;
    //   }
    // });

  //   setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _sliderValueNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? GestureDetector(
          onDoubleTap: () {
            setState(() {
              widget.videoData['liked'] = !widget.videoData['liked'];
            });
          },
          child: Chewie(
            controller: _chewieController!,
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamily,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery
                .of(context)
                .size
                .width * 0.02,
            right: MediaQuery
                .of(context)
                .size
                .width * 0.03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                    width: ScreenSize.screenWidth(context) * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                    widget.videoData['profilePhoto']),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  widget.videoData['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontFamily,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.verified, size: 15, color: Colors.white),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSubscribed = !_isSubscribed;
                                  });
                                },
                                child: Container(
                                  height: ScreenSize.screenHeight(context) * 0.045,
                                  width: _isSubscribed ? ScreenSize.screenWidth(context) * 0.28 : ScreenSize.screenWidth(context) * 0.25,
                                  decoration: BoxDecoration(
                                    color: _isSubscribed ? Colors.grey.shade200 : Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _isSubscribed ? 'Unsubscribe' : 'Subscribe',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isSubscribed ? Colors.black : Colors.white,
                                        fontFamily: fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          widget.videoData['description'],
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontFamily,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.videoData['originalAudio'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: fontFamily,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.videoData['liked'] =
                              !widget.videoData['liked'];
                            });
                          },
                          child: Icon(
                            widget.videoData['liked']
                                ? HeroiconsSolid.handThumbUp
                                : HeroiconsOutline.handThumbUp,
                            color: widget.videoData['liked']
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.videoData['likes'],
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontFamily,
                          ),
                        ),
                        SizedBox(height: 20),
                        Icon(
                          HeroiconsOutline.handThumbDown,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        // Text(
                        //   '601k',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontFamily: fontFamily,
                        //   ),
                        // ),
                        SizedBox(height: 20),
                        Icon(
                          HeroiconsOutline.chatBubbleBottomCenterText,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.videoData['comments'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontFamily,
                          ),
                        ),
                        SizedBox(height: 20),
                        Transform(
                          transform: Matrix4.rotationZ(5.8),
                          child: Icon(
                            HeroiconsOutline.paperAirplane,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 50),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}