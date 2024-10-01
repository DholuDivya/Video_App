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
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import '../../bloc/get_user_playlist/get_user_playlist_bloc.dart';
import '../../bloc/get_user_playlist/get_user_playlist_event.dart';
import '../../bloc/remove_video_from_history/remove_video_from_history_bloc.dart';
import '../../bloc/remove_video_from_history/remove_video_from_history_event.dart';
import '../../utils/widgets/customBottomSheet.dart';
import '../../utils/widgets/custom_channel_video_preview.dart';
import '../../utils/widgets/custom_save_to_playlist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllHistoryPage extends StatelessWidget {
  const AllHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context) {
      return [
        {'name': AppLocalizations.of(context)!.saveToPlaylist, 'icon': HeroiconsOutline.bookmark},
        {'name': AppLocalizations.of(context)!.downloadVideo, 'icon': HeroiconsOutline.arrowDownTray},
        {'name': AppLocalizations.of(context)!.share, 'icon': HeroiconsOutline.share},
        {'name': AppLocalizations.of(context)!.removeFromHistory, 'icon': HeroiconsOutline.trash},
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
    final userChannelId = Global.userData!.userChannelId;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.history,
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<GetUserHistoryBloc, GetUserHistoryState>(
              builder: (context, state){
                if(state is GetUserHistorySuccess){
                  return Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        // Check if the user has scrolled to the end and load more notes if needed
                        if (!state.hasReachedMax &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          context.read<GetUserHistoryBloc>().add(LoadMoreUserHistory());
                        }
                        return false;
                      },
                      child: state.userHistory.isNotEmpty ? ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        // padding: EdgeInsets.only(
                        //   top: ScreenSize.screenHeight(context) * 0.01,
                        // ),
                          itemCount: state.hasReachedMax
                              ? state.userHistory.length
                              : state.userHistory.length + 1,
                          itemBuilder: (context, index){
                            final userHistory = state.userHistory[index];
                            final totalSeconds = userHistory.duration;
                            final formattedDuration = formatDuration(totalSeconds!);

                            if (index == state.userHistory.length) {
                              return Center(child: CircularProgressIndicator());
                            }
                    
                            return InkWell(
                              onTap: (){
                                GoRouter.of(context).pushNamed('videoPage',
                                    pathParameters: {
                                      "slug": userHistory.slug!
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
                                  imageUrl: '${userHistory.thumbnail}',
                                  videoTitle: '${userHistory.title}',
                                  videoViews: userHistory.views.toString(),
                                  uploadTime: '${userHistory.createdAtHuman}',
                                  videoDuration: formattedDuration,
                                  onShowMorePressed: (){
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
                                          showPlaylistBottomSheet(userHistory.id!, userChannelId);
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
                          }
                      ) : Container(
                        // color: yellow,
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // color: red,
                                height: 120.h,
                                width: 240.w,
                                child: Image.asset('assets/images/no_data.png'),
                              ),
                              Text(
                                AppLocalizations.of(context)!.historyNotFound,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15.sp
                                ),
                              ),
                            ],
                          ),)
                      ),
                    ),
                  );

                }
                return Container();
          })
        ],
      ),
    );
  }
}
