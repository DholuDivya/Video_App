import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/custom_playlist_preview.dart';

class PlaylistPreviewPage extends StatefulWidget {
  const PlaylistPreviewPage({super.key});

  @override
  State<PlaylistPreviewPage> createState() => _PlaylistPreviewPageState();
}

class _PlaylistPreviewPageState extends State<PlaylistPreviewPage> {

  List<Map<String, dynamic>> videoList = [
    {"thumbnail": "assets/images/tmkoc10.jpg", "views": "1.2M"},
    {"thumbnail": "assets/images/tmkoc9.jpg", "views": "876K"},
    {"thumbnail": "assets/images/tmkoc8.jpg", "views": "1M"},
    {"thumbnail": "assets/images/tmkoc7.jpg", "views": "432K"},
    {"thumbnail": "assets/images/tmkoc6.jpg", "views": "200K"},
    {"thumbnail": "assets/images/tmkoc5.jpg", "views": "56.9K"},
    {"thumbnail": "assets/images/tmkoc4.jpg", "views": "103K"},
    {"thumbnail": "assets/images/tmkoc3.jpg", "views": "760K"},
    {"thumbnail": "assets/images/tmkoc2.jpg", "views": "1.2M"},
    {"thumbnail": "assets/images/tmkoc1.jpg", "views": "144K"},
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(
                top: 0,
                bottom: ScreenSize.screenHeight(context) * 0.01,
              ),
              itemCount: videoList.length,
              itemBuilder: (BuildContext context, int index){
                return CustomPlaylistPreview(
                    imageUrl: videoList[index]['thumbnail'],
                    playlistName: 'Tarak Mehta ka Ooltah Chashma',
                    channelName: 'Sony Sab',
                    numberOfVideos: 5,
                );
              }
          )
        ],
      ),
    );
  }
}
