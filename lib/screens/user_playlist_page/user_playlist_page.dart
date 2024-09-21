 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/utils/widgets/custom_playlist_preview.dart';

class UserPlaylistPage extends StatelessWidget {
  const UserPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('channellllllllll :::::::::   ${Global.userData!.userChannelId}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Playlists',
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.userPlaylist.length,
                            itemBuilder: (context, index){
                            final userPlaylist = state.userPlaylist[index];
                            final playlistId = userPlaylist.id;
                              return InkWell(
                                onTap: (){
                                  Future.delayed(const Duration(milliseconds: 200),(){
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
                                      channelName: 'Channel'
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ) : const Center(child: Text('Playlist not found'),);
                  }
                  return Container();
                }
            )
          ],
        ),
      ),
    );
  }
}
