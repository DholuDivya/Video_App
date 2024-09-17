import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';

class OfflineVideoPlayer extends StatefulWidget {

  const OfflineVideoPlayer({super.key});

  @override
  _OfflineVideoPlayerState createState() => _OfflineVideoPlayerState();
}

class _OfflineVideoPlayerState extends State<OfflineVideoPlayer> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  late BannerAd bannerAd;
  bool isAdLoaded = false;






  @override
  void initState() {
    super.initState();
    initBannerAd();
    // _controller = VideoPlayerController.file(File(widget.filePath))
    //   ..initialize().then((_) {
    //     setState(() {
    //       _chewieController = ChewieController(
    //         videoPlayerController: _controller,
    //         autoPlay: false,
    //         looping: false,
    //       );
    //     });
    //   });
  }


  initBannerAd(){
    print('sgnhsfujgs');
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-2734509756038446/1670883979',
        listener: BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                isAdLoaded = true;
              });
            },
            onAdFailedToLoad: (ad, error){
              ad.dispose();
              print(error);
            }
        ),
        request: const AdRequest()
    );

    bannerAd.load();
  }



  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Play Video')),

      body: isAdLoaded ? SizedBox(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd),
      ) : SizedBox(),


      // body: Center(
      //   child: _controller.value.isInitialized
      //       ? Chewie(
      //     controller: _chewieController!,
      //   )
      //       : CircularProgressIndicator(),
      // ),
    );
  }
}
