import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_event.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import '../../../utils/widgets/customBottomSheet.dart';
import '../../../utils/widgets/custom_channel_video_preview.dart';
import '../../../utils/widgets/custom_for_you_preview.dart';
import '../../../utils/widgets/custom_report_dialog.dart';
import '../../../utils/widgets/custom_save_to_playlist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePreviewPage extends StatefulWidget {
  const HomePreviewPage({super.key});

  @override
  State<HomePreviewPage> createState() => _HomePreviewPageState();
}

class _HomePreviewPageState extends State<HomePreviewPage> {

  final userChannelId = Global.userData!.userChannelId;

  List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context) {
    return [
      {'name': AppLocalizations.of(context)!.saveToPlaylist, 'icon': HeroiconsOutline.bookmark},
      {'name': AppLocalizations.of(context)!.downloadVideo, 'icon': HeroiconsOutline.arrowDownTray},
      {'name': AppLocalizations.of(context)!.share, 'icon': HeroiconsOutline.share},
      {'name': AppLocalizations.of(context)!.report, 'icon': HeroiconsOutline.chatBubbleBottomCenterText},
    ];
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
      builder: (BuildContext context, ChannelProfileState state) {
        if (state is ChannelProfileLoaded) {
          final channelData = state.channelData;

          if (channelData != null && channelData.isNotEmpty) {
            final isAssociated = channelData.first.isAssociated;

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (!isAssociated!)
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenSize.screenHeight(context) * 0.015,
                            left: ScreenSize.screenWidth(context) * 0.044,
                            bottom: ScreenSize.screenHeight(context) * 0.015,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.forYou,
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      if (!isAssociated)
                        SizedBox(
                          height: ScreenSize.screenHeight(context) * 0.285,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                left: ScreenSize.screenWidth(context) * 0.04),
                            scrollDirection: Axis.horizontal,
                            itemCount: channelData.first.suggestedVideos?.length ?? 0,
                            itemBuilder: (context, index) {
                              final suggestedVideo = channelData.first.suggestedVideos![index];
                              final type = suggestedVideo.type;
                              if (type == "video") {
                                return ForYouPreview(
                                  videoThumbnail: suggestedVideo.thumbnails!,
                                  videoTitle: suggestedVideo.title!,
                                  channelName: channelData.first.channel!.name!,
                                  uploadTime: suggestedVideo.createdAtHuman!,
                                  onShowMorePressed: (){
                                    customShowMoreBottomSheet(
                                      context,
                                      bottomSheetListTileField(context),
                                          (int index) {
                                        if (index == 0) {
                                          if(Navigator.canPop(context)){
                                            Navigator.pop(context);
                                          }
                                          context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                          showPlaylistBottomSheet(suggestedVideo.id!, userChannelId!);
                                        }
                                        else if (index == 1) {}
                                        else if (index == 2) {
                                          final String appLink = '${baseUrl}share?video=${suggestedVideo.slug}';
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
                                          showReportDialog(context, suggestedVideo.id!);
                                        }
                                      },
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenSize.screenHeight(context) * 0.015,
                          left: ScreenSize.screenWidth(context) * 0.044,
                          bottom: ScreenSize.screenHeight(context) * 0.015,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.videos,
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<YourVideosBloc, YourVideosState>(
                  builder: (BuildContext context, YourVideosState state) {
                    if (state is YourVideosLoaded) {
                      final videoDataLength = state.yourVideoData.length;

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: videoDataLength + 1,
                              (BuildContext context, int index) {
                            if (index == videoDataLength) {
                              return SizedBox(height: 12.h);
                            }

                            final videoData = state.yourVideoData[index];
                            final totalSeconds = videoData.duration;
                            final formattedTime =
                            totalSeconds != null ? formatDuration(totalSeconds) : 'N/A';

                            return Padding(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: CustomVideoPreview(
                                imageUrl: videoData.thumbnail!,
                                videoTitle: videoData.title!,
                                videoViews: videoData.views.toString(),
                                uploadTime: '${videoData.createdAtHuman}',
                                videoDuration: formattedTime,
                                onShowMorePressed: () {
                                  customShowMoreBottomSheet(
                                    context,
                                    bottomSheetListTileField(context),
                                        (int index) {
                                      if (index == 0) {
                                        if(Navigator.canPop(context)){
                                          Navigator.pop(context);
                                        }
                                        context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                        showPlaylistBottomSheet(videoData.id!, userChannelId!);
                                      }
                                      else if (index == 1) {}
                                      else if (index == 2) {
                                        final String appLink = '${baseUrl}share?video=${videoData.slug}';
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
                                        showReportDialog(context, videoData.id!);
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container(
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
                              AppLocalizations.of(context)!.videoNotFound,
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 15.sp
                              ),
                            ),
                          ],
                        ),)
                    ); // Empty state for YourVideosBloc
                  },
                ),
              ],
            );
          } else {
            return Container(); // Empty state for ChannelProfileBloc
          }
        }
        return Container(); // Empty state while loading
      },
    );
  }

  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomReportDialog(videoId: videoId);
      },
    );
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



}

