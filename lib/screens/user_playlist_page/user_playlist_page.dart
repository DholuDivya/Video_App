import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
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
                    return state.userPlaylist.first.playlists!.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.userPlaylist.first.playlists!.length,
                        itemBuilder: (context, index){
                        final userPlaylist = state.userPlaylist.first.playlists![index];
                          return InkWell(
                            onTap: (){},
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
