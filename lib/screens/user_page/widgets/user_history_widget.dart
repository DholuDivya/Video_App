import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/remove_video_from_history/remove_video_from_history_bloc.dart';
import 'package:vimeo_clone/bloc/remove_video_from_history/remove_video_from_history_event.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_history_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/shimmer.dart';
import '../../../bloc/get_user_playlist/get_user_playlist_bloc.dart';
import '../../../bloc/get_user_playlist/get_user_playlist_event.dart';
import '../../../config/global_variable.dart';
import '../../../utils/widgets/customBottomSheet.dart';
import '../../../utils/widgets/custom_save_to_playlist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserHistoryWidget extends StatefulWidget {
  const UserHistoryWidget({super.key});

  @override
  State<UserHistoryWidget> createState() => _UserHistoryWidgetState();
}

class _UserHistoryWidgetState extends State<UserHistoryWidget> {

  var historyLength = 0;
  final userChannelId = Global.userData!.userChannelId;

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());

    final historyBloc = context.read<GetUserHistoryBloc>();
    historyBloc.stream.listen((state){
      if(state is GetUserHistorySuccess){
        historyLength = state.userHistory.length;
      }
    });

    super.initState();
  }



  List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context) {
    return [
      {
        'name': AppLocalizations.of(context)!.saveToPlaylist,
        'icon': HeroiconsOutline.bookmark
      },
      {
        'name': AppLocalizations.of(context)!.downloadVideo,
        'icon': HeroiconsOutline.arrowDownTray
      },
      {
        'name': AppLocalizations.of(context)!.share,
        'icon': HeroiconsOutline.share
      },
      {
        'name': AppLocalizations.of(context)!.removeFromHistory,
        'icon': HeroiconsOutline.trash
      },
    ];
  }

  void showPlaylistBottomSheet(int videoId, String userChannelId){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) {
        return PlaylistBottomSheet(
          videoId: videoId, // Pass your video data
          userChannelId: userChannelId, // Pass your user channel ID
        );
      },
    ).whenComplete((){
      context.read<PlaylistSelectionBloc>().add(ClearPlaylistSelectionRequest());
      context.read<AddVideoToPlaylistBloc>().add(InitializePlaylistBloc());
    });
  }


  List<int> selectedToRemove = [];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserHistoryBloc, GetUserHistoryState>(
      builder: (BuildContext context, GetUserHistoryState state) {
        if(state is GetUserHistorySuccess){
          return state.userHistory.length != 0 ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenSize.screenWidth(context) * 0.04,
                    right: ScreenSize.screenWidth(context) * 0.01
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.history,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: 15,
                      // color: Colors.red,
                      onPressed: (){
                        GoRouter.of(context).pushNamed('allHistoryPage');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.viewAll,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: fontFamily
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              BlocBuilder<GetUserHistoryBloc, GetUserHistoryState>(
                builder: (BuildContext context, GetUserHistoryState state) {
                  if (state is GetUserHistorySuccess) {
                    final reversedUserHistory = state.userHistory.reversed.toList(); // Reversing the data list

                    return Container(
                      height: ScreenSize.screenHeight(context) * 0.21,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          left: ScreenSize.screenWidth(context) * 0.04,
                        ),
                        itemCount: reversedUserHistory.length,
                        itemBuilder: (context, index) {
                          final userHistory = reversedUserHistory[index];
                          final totalSeconds = userHistory.duration;
                          final formattedDuration = formatDuration(totalSeconds!);

                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenSize.screenWidth(context) * 0.04,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Future.delayed(const Duration(milliseconds: 100), () {
                                  GoRouter.of(context).pushNamed('videoPage', pathParameters: {
                                    "slug": userHistory.slug!,
                                  });
                                });
                              },
                              child: HistoryVideoPreview(
                                imageUrl: '${userHistory.thumbnail}',
                                videoTitle: '${userHistory.title}',
                                channelName: '${userHistory.channel!.name}',
                                videoDuration: formattedDuration,
                                onMorePressed: () {
                                  selectedToRemove.add(userHistory.id!);
                                  customShowMoreBottomSheet(
                                    context,
                                    bottomSheetListTileField(context),
                                        (int index) {
                                      if (index == 0) {
                                        if(Navigator.canPop(context)){
                                          Navigator.pop(context);
                                        }
                                        context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                        showPlaylistBottomSheet(userHistory.id!, userChannelId!);
                                      }
                                      else if (index == 1) {}
                                      else if (index == 2) {

                                        final String appLink = '${baseUrl}share?video=${userHistory.slug}';
                                        if(Navigator.canPop(context)){
                                          Navigator.pop(context);
                                        }
                                        // Use the share_plus package to share the link
                                        Share.share('Check out this video: $appLink');
                                      }
                                      else if (index == 3) {

                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                        context.read<RemoveVideoFromHistoryBloc>().add(
                                            RemoveVideoFromHistoryRequest(videoIds: selectedToRemove));
                                        context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());

                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                        left: ScreenSize.screenWidth(context) * 0.04,
                      ),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ShimmerWidget.rectangular(
                            isBorder: true,
                            height: 80.h,
                            width: 180.w,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),


              SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),

            ],
          ) : SizedBox.shrink();
        }
        return SizedBox.shrink();
      },
    );
  }

}

