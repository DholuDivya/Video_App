import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/customBottomSheet.dart';
import 'package:vimeo_clone/utils/widgets/custom_playlist_preview.dart';
import '../../homePage/homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PlaylistPreviewPage extends StatefulWidget {
  // final GetChannelDetailModel channelData;
  const PlaylistPreviewPage({super.key,});

  @override
  State<PlaylistPreviewPage> createState() => _PlaylistPreviewPageState();
}

class _PlaylistPreviewPageState extends State<PlaylistPreviewPage> {


  List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context) {
    return [
      {
        'name': AppLocalizations.of(context)!.saveToLibrary,
        'icon': HeroiconsOutline.bookmark
      },
      {
        'name': AppLocalizations.of(context)!.share,
        'icon': HeroiconsOutline.share
      },
    ];
  }


  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(videoId: videoId,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
      builder: (BuildContext context, GetUserPlaylistState state) {
        if(state is GetUserPlaylistSuccess){
          return SingleChildScrollView(
            child: state.userPlaylist.isNotEmpty ? Column(
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
                          numberOfVideos: 0,
                          onShowMorePressed: (){
                            customShowMoreBottomSheet(
                                context, bottomSheetListTileField(context),
                                    (int index) {
                                  if (index == 0) {
                                    GoRouter.of(context).pushNamed('editVideoDetailPage');
                                  }
                                  else if (index == 1) {}
                                });
                          },
                        ),
                      ) : Container();
                    }
                )
              ],
            ) : Container(
              // color: yellow,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // color: red,
                        height: 120.h,
                        width: 240.w,
                        child: Image.asset('assets/images/no_data.png'),
                      ),
                      Text(
                        AppLocalizations.of(context)!.playlistNotFound,
                        style: TextStyle(
                            fontFamily: fontFamily, fontSize: 15.sp
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }
        return Container();
      },
    );
  }
}
