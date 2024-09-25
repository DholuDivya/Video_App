import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/custom_playlist_preview.dart';

import '../../../config/colors.dart';

class PlaylistPreviewPage extends StatefulWidget {
  // final GetChannelDetailModel channelData;
  const PlaylistPreviewPage({super.key,});

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
    return BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
      builder: (BuildContext context, GetUserPlaylistState state) {
        if(state is GetUserPlaylistSuccess){
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      top: 5.h,
                      bottom: ScreenSize.screenHeight(context) * 0.01,
                    ),
                    itemCount: state.userPlaylist.length,
                    itemBuilder: (BuildContext context, int index){
                      final userPlaylist = state.userPlaylist[index];
                      return state.userPlaylist.isNotEmpty
                          ? Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                        child: CustomPlaylistPreview(
                          imageUrl: '',
                          playlistName: userPlaylist.title!,
                          channelName: userPlaylist.visibility!,
                          numberOfVideos: 0,),
                      ) : Container();
                    }
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
