 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/utils/widgets/custom_playlist_preview.dart';

import '../../bloc/show_single_playlist/show_single_playlist_bloc.dart';
import '../../bloc/show_single_playlist/show_single_playlist_event.dart';
import '../../utils/widgets/customBottomSheet.dart';

class UserPlaylistPage extends StatelessWidget {
  const UserPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('channellllllllll :::::::::   ${Global.userData!.userChannelId}');

    List<Map<String, dynamic>> bottomSheetListTileField = [
      {'name': 'Delete', 'icon': HeroiconsOutline.trash},
      {'name': 'Share', 'icon': HeroiconsOutline.share},
    ];


    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Playlists',
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
              builder: (BuildContext context, GetUserPlaylistState state){
                if(state is GetUserPlaylistSuccess){
                  return state.userPlaylist.isNotEmpty ? NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      // Check if the user has scrolled to the end and load more notes if needed
                      if (!state.hasReachedMax &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        context.read<GetUserPlaylistBloc>().add(LoadMoreUserPlaylist());
                      }
                      return false;
                    },
                    child: Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,

                          itemCount: state.userPlaylist.length,
                          itemBuilder: (context, index){
                          final userPlaylist = state.userPlaylist[index];
                          final playlistId = userPlaylist.id;
                            return InkWell(
                              onTap: (){
                                print('nnnnnnnnnnnnnnnnnnnn     $playlistId');
                                context.read<ShowSinglePlaylistBloc>().add(ShowSinglePlaylistRequest(playlistId: playlistId!));
                                Future.delayed(const Duration(milliseconds: 500),(){
                                  GoRouter.of(context).pushNamed('singlePlaylistPage',
                                      pathParameters: {
                                        'playlistId' : playlistId.toString()
                                      }
                                  );
                                });
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.h,
                                    bottom: 6.h
                                  ),
                                child: CustomPlaylistPreview(
                                    imageUrl: userPlaylist.videos!.isEmpty ? '' : userPlaylist.videos!.first.thumbnails!,
                                    numberOfVideos: userPlaylist.videos!.length,
                                    playlistName: userPlaylist.title!,
                                    channelName: 'Channel',
                                  onShowMorePressed: (){
                                    customShowMoreBottomSheet(
                                        context, bottomSheetListTileField,
                                            (int index) {
                                          if (index == 0) {}
                                          else if (index == 1) {}
                                        });
                                  },
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  ) : Container(
                    // color: yellow,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: red,
                          height: 120.h,
                          width: 250.w,
                          child: Image.asset('assets/images/no_data.png'),
                        ),
                        Text(
                          'Playlist not found!!',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    ),),
                  );
                }
                return Container();
              }
          )
        ],
      ),
    );
  }
}
