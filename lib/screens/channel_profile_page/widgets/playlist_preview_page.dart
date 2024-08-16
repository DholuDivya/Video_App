import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/custom_playlist_preview.dart';

import '../../../config/colors.dart';

class PlaylistPreviewPage extends StatefulWidget {
  final GetChannelDetailModel channelData;
  const PlaylistPreviewPage({super.key, required this.channelData});

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
                top: 5.h,
                bottom: ScreenSize.screenHeight(context) * 0.01,
              ),
              itemCount: widget.channelData.playlists!.length,
              itemBuilder: (BuildContext context, int index){
                final userPlaylist = widget.channelData.playlists![index];
                return widget.channelData.playlists!.isNotEmpty 
                    ? Padding(
                      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: CustomPlaylistPreview(
                          imageUrl: '',
                          playlistName: userPlaylist.title!,
                          channelName: userPlaylist.visibility!,
                          numberOfVideos: 0,),
                    ) : Container(color: red,);
              }
          )
        ],
      ),
    );
  }
}
