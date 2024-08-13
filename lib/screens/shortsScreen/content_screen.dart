import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_shorts_list_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContentScreen extends StatefulWidget {
  final Data shortsData;

  const ContentScreen({super.key, required this.shortsData});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool _isSubscribed = false;
  PodPlayerController? _podPlayerController;
  late ValueNotifier<double> _sliderValueNotifier;
  bool isPause = false;


  @override
  void initState() {
    super.initState();
    _sliderValueNotifier = ValueNotifier(0.0);
    initializePlayer();
    _podPlayerController?.hideOverlay();
    // enterImmersiveMode();
  }

  void toggle(){
    setState(() {
      isPause = !isPause;
    });
  }

  Future initializePlayer() async {
    setState(() {
      // _podPlayerController = PodPlayerController(
      //     playVideoFrom: PlayVideoFrom.youtube('https://www.youtube.com/watch?v=nfl1rW7CWog'),
      //         podPlayerConfig: const PodPlayerConfig(
      //     isLooping: true,
      //           autoPlay: true,
      //           videoQualityPriority: [720, 360]
      // )

      // )..initialise();

      _podPlayerController = PodPlayerController(
        playVideoFrom: widget.shortsData.uploadedBy == "external"
            ? PlayVideoFrom.youtube(widget.shortsData.video!,)
            : PlayVideoFrom.network(widget.shortsData.video!,),
        podPlayerConfig: const PodPlayerConfig(
          isLooping: true,
          autoPlay: true,
        )
      )..initialise();
    });
  }

  @override
  void dispose() {
    _sliderValueNotifier.dispose();
    _podPlayerController?.dispose();
    super.dispose();
    // exitImmersiveMode();
  }


  void enterImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

// Call this method when you want to exit immersive mode
  void exitImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        _podPlayerController != null ? GestureDetector(
          onTap: (){

              toggle();
              isPause ? _podPlayerController?.pause() : _podPlayerController?.play();
            },
          child: AspectRatio(
            aspectRatio: 9/16,
            child: PodVideoPlayer(
                controller: _podPlayerController!,
              alwaysShowProgressBar: false,
              overlayBuilder: (options) {
                return const SizedBox.shrink();
              },
                matchVideoAspectRatioToFrame: true,
                matchFrameAspectRatioToVideo: true,
            ),
          ),
        ) : const Center(child:  CircularProgressIndicator(),),
        GestureDetector(
          onTap: (){
            toggle();
            isPause ? _podPlayerController?.pause() : _podPlayerController?.play();
          },
            child: Icon(
              isPause ? (Icons.play_arrow) : null, color: Colors.white70, size: 40,
            )
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.03,
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
                                    widget.shortsData.channel!.logo!),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  widget.shortsData.channel!.name!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fontFamily,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.verified,
                                  size: 15, color: Colors.white),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSubscribed = !_isSubscribed;
                                  });
                                },
                                child: Container(
                                  height:
                                      ScreenSize.screenHeight(context) * 0.045,
                                  width: _isSubscribed
                                      ? ScreenSize.screenWidth(context) * 0.28
                                      : ScreenSize.screenWidth(context) * 0.25,
                                  decoration: BoxDecoration(
                                    color: _isSubscribed
                                        ? Colors.grey.shade200
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _isSubscribed
                                          ? 'Unsubscribe'
                                          : 'Subscribe',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isSubscribed
                                            ? Colors.black
                                            : Colors.white,
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
                          widget.shortsData.description!,
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
                                'originalAudio',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontFamily,
                                    overflow: TextOverflow.ellipsis),
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
                            // setState(() {
                            //   widget.videoData['liked'] =
                            //       !widget.videoData['liked'];
                            // });
                          },
                          child: Icon(
                            // widget.videoData['liked']
                            //     ? HeroiconsSolid.handThumbUp
                            //     :handThumbUp
                            HeroiconsOutline.handThumbUp,
                            color:
                            // widget.videoData['liked']
                            //     ? Colors.blue
                            //     :
                            Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.shortsData.likes!.toString(),
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
                          widget.shortsData.comments.toString(),
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
