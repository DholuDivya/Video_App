import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_event.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_channel_preview.dart';

import '../../utils/widgets/custom_channel_video_preview.dart';

class SinglePlaylistPage extends StatefulWidget {
  final int playlistId;
  const SinglePlaylistPage({super.key, required this.playlistId});

  @override
  State<SinglePlaylistPage> createState() => _SinglePlaylistPageState();
}

class _SinglePlaylistPageState extends State<SinglePlaylistPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(HeroiconsOutline.ellipsisVertical)
          )
        ],
      ),
      body: BlocBuilder<ShowSinglePlaylistBloc, ShowSinglePlaylistState>(
        builder: (BuildContext context, ShowSinglePlaylistState state) {
          if(state is ShowSinglePlaylistLoaded){
            final userSinglePlaylist = state.singlePlaylistData.first.playlist;
            return userSinglePlaylist!.videos!.isNotEmpty ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 255.h,
                    width: double.infinity,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // borderRadius: BorderRadius.only(
                      //  
                      //   bottomLeft: Radius.circular(20),
                      //   bottomRight: Radius.circular(20),
                      //
                      // ),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h,
                              left: 20.w,
                              right: 20.w,
                              bottom: 20.w
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AspectRatio(
                                  aspectRatio: 16/9,
                                  child: Image.network(userSinglePlaylist.videos!.first.thumbnails!, fit: BoxFit.cover,),
                                ),
                              ),
                              SizedBox(height: 10.h,),

                              Text(
                                '${userSinglePlaylist.title}',
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 17
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Channel Name',
                                        style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 12
                                        ),
                                      ),
                                      Text(
                                        '${userSinglePlaylist.videos!.length} videos  -  ${userSinglePlaylist.visibility}',
                                        style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 10,
                                            color: greyShade500
                                        ),
                                      )
                                    ],
                                  ),

                                  InkWell(
                                    onTap: (){},
                                    child: Container(
                                      height: 30.h,
                                      width: 35.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white.withOpacity(0.4)
                                      ),
                                      child: const Icon(HeroiconsOutline.pencilSquare, size: 20,),
                                    ),
                                  )
                                ],
                              )


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(height: 15.h,),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        ),
                        color: Colors.transparent
                        // color: Theme.of(context).colorScheme.surface
                    ),
                    padding: EdgeInsets.only(top: 10.h),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // padding: EdgeInsets.only(
                        //   top: ScreenSize.screenHeight(context) * 0.01,
                        // ),
                        itemCount: state.singlePlaylistData.first.playlist!.videos!.length,
                        itemBuilder: (context, index){
                          final userSinglePlaylistData = userSinglePlaylist.videos![index];
                          final totalSeconds = userSinglePlaylistData.duration;
                          final formattedDuration = formatDuration(totalSeconds!);
                          return InkWell(
                            onTap: (){
                              GoRouter.of(context).pushNamed('videoPage',
                                  pathParameters: {
                                    "slug": userSinglePlaylistData.slug!
                                  });
                              // WidgetsBinding.instance.addPostFrameCallback((_){
                              //
                              // });

                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 4.h,
                                  bottom: 4.h
                              ),
                              child: CustomVideoPreview(
                                imageUrl: '${userSinglePlaylistData.thumbnails}',
                                videoTitle: '${userSinglePlaylistData.title}',
                                videoViews: userSinglePlaylistData.views.toString(),
                                uploadTime: '${userSinglePlaylistData.createdAtHuman}',
                                videoDuration: formattedDuration,
                              ),
                            ),
                          );
                        }
                    )
                  ),



                ],
              ),
            ) : const Center(child: Text('Videos not found!!'),);
          }else if(state is ShowSinglePlaylistLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
