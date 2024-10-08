import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/remove_video_from_playlist/remove_video_from_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/remove_video_from_playlist/remove_video_from_playlist_event.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_event.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/widgets/customBottomSheet.dart';
import '../../utils/widgets/custom_channel_video_preview.dart';

class SinglePlaylistPage extends StatefulWidget {
  final int playlistId;
  const SinglePlaylistPage({super.key, required this.playlistId});

  @override
  State<SinglePlaylistPage> createState() => _SinglePlaylistPageState();
}

class _SinglePlaylistPageState extends State<SinglePlaylistPage> {

  final channelId = Global.userData!.userChannelId;

  List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context) {
    return [
      {
        'name': AppLocalizations.of(context)!.removeFromPlaylist,
        'icon': HeroiconsOutline.trash
      },
      {
        'name': AppLocalizations.of(context)!.downloadVideo,
        'icon': HeroiconsOutline.arrowDownTray
      },
      {
        'name': AppLocalizations.of(context)!.share,
        'icon': HeroiconsOutline.share
      },
    ];
  }


  int selectedToRemove = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(channelId!)));
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back)
        ),
      ),
      body: BlocBuilder<ShowSinglePlaylistBloc, ShowSinglePlaylistState>(
        builder: (BuildContext context, ShowSinglePlaylistState state) {
          if(state is ShowSinglePlaylistLoaded){
            final playlistTitle = context.read<ShowSinglePlaylistBloc>().playlistTitle;
            final playlistVisibility = context.read<ShowSinglePlaylistBloc>().playlistVisibility;
            final userSinglePlaylist = state.singlePlaylistData;
            return userSinglePlaylist.isNotEmpty ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h,
                              left: 20.w,
                              right: 20.w,
                              bottom: 10.h
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AspectRatio(
                                  aspectRatio: 16/9,
                                  child: Image.network(userSinglePlaylist.first.thumbnails!, fit: BoxFit.cover,),
                                ),
                              ),
                              SizedBox(height: 10.h,),

                              Text(
                                playlistTitle,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              // SizedBox(height: 5.h,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   '${userSinglePlaylist.first.channel!.name}',
                                      //   style: TextStyle(
                                      //       fontFamily: fontFamily,
                                      //       fontSize: 12
                                      //   ),
                                      // ),
                                      Text(
                                        '${userSinglePlaylist.length} ${AppLocalizations.of(context)!.video}  -  $playlistVisibility',
                                        style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 12.sp,
                                            color: greyShade500
                                        ),
                                      )
                                    ],
                                  ),

                                  // InkWell(
                                  //   onTap: (){},
                                  //   child: Container(
                                  //     height: 30.h,
                                  //     width: 35.w,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(100),
                                  //         color: Colors.white.withOpacity(0.4)
                                  //     ),
                                  //     child: const Icon(HeroiconsOutline.pencilSquare, size: 20,),
                                  //   ),
                                  // )
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
                        itemCount: state.singlePlaylistData.length,
                        itemBuilder: (context, index){
                          final userSinglePlaylistData = userSinglePlaylist[index];
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
                                onShowMorePressed: (){
                                  selectedToRemove = userSinglePlaylistData.id!;
                                  customShowMoreBottomSheet(
                                    context,
                                    bottomSheetListTileField(context),
                                        (int index) {
                                      if (index == 0) {
                                        context.read<RemoveVideoFromPlaylistBloc>().add(
                                            RemoveVideoFromPlaylistRequest(
                                              videoId: selectedToRemove,
                                              playlistId: widget.playlistId
                                            ));
                                        context.read<ShowSinglePlaylistBloc>().add((ShowSinglePlaylistRequest(playlistId: widget.playlistId)));

                                        Future.delayed(const Duration(milliseconds: 200), (){
                                          Navigator.pop(context);
                                        });
                                      } else if (index == 1) {
                                        // GoRouter.of(context).pushNamed('settingPage');
                                      } else if (index == 2){
                                        final String appLink = '${baseUrl}share?video=${userSinglePlaylistData.slug}';
                                        if(Navigator.canPop(context)){
                                          Navigator.pop(context);
                                        }
                                        // Use the share_plus package to share the link
                                        Share.share('Check out this video: $appLink');
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    )
                  ),



                ],
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
                      AppLocalizations.of(context)!.videoNotFound,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15.sp
                      ),
                  ),
                ],
              ),),
            );
          }else if(state is ShowSinglePlaylistLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
