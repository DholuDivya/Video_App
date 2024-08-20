import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_playlist_widget_userpage.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';
import 'package:vimeo_clone/utils/widgets/shimmer.dart';
import 'package:vimeo_clone/utils/widgets/toggle_button.dart';
import '../../../bloc/get_user_playlist/get_user_playlist_event.dart';
import '../../../config/colors.dart';

class UserPlaylistWidget extends StatefulWidget {
  UserPlaylistWidget({super.key});

  @override
  State<UserPlaylistWidget> createState() => _UserPlaylistWidgetState();
}

class _UserPlaylistWidgetState extends State<UserPlaylistWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.04,
              right: ScreenSize.screenWidth(context) * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlist',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w500),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  // side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 15,
                // color: Colors.red,
                onPressed: () {
                  GoRouter.of(context).pushNamed('userPlaylistPage');
                },
                child: const Text(
                  'View all',
                  style: TextStyle(fontSize: 12, fontFamily: fontFamily),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
          builder: (BuildContext context, GetUserPlaylistState state) {
            if (state is GetUserPlaylistSuccess) {
              final userPlaylistLength =
                  state.userPlaylist.first.playlists!.length;

              return Container(
                height: ScreenSize.screenHeight(context) * 0.21,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    left: ScreenSize.screenWidth(context) * 0.04,
                  ),

                  itemCount: userPlaylistLength + 1,
                  itemBuilder: (context, index) {

                    if (index == userPlaylistLength) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: ScreenSize.screenWidth(context) * 0.04,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: (){
                            createPlaylistAlertDialog();
                          },
                          child: Container(
                            height: 150.h,
                            width: 180.w,
                            // decoration: BoxDecoration(
                            //   color: Colors.grey[200],
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: greyShade300,
                                    ),
                                    child: Icon(
                                        HeroiconsOutline.plus,
                                        size: 35
                                    )
                                ),
                                SizedBox(height: 25.h),
                                Text('Create new playlist'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    // Fetch the user playlist data for the current index
                    final userPlaylist =
                        state.userPlaylist.first.playlists![index];

                    return Padding(
                      padding: EdgeInsets.only(
                        right: ScreenSize.screenWidth(context) * 0.04,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          GoRouter.of(context).pushNamed('singlePlaylistPage');
                        },
                        child: CustomPlaylistWidgetUserPage(
                          numberOfVideos: userPlaylist.videos!.length,
                          imageUrl: userPlaylist.videos!.isEmpty
                              ? ''
                              : userPlaylist.videos!.first.thumbnails!,
                          playlistTitle: userPlaylist.title!,
                          playlistVisibility: userPlaylist.visibility!,
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            // Shimmer loading placeholder for when the state is not successful
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
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
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
        SizedBox(
          height: ScreenSize.screenHeight(context) * 0.01,
        ),
      ],
    );
  }

  final TextEditingController playlistTitleController = TextEditingController();

  final TextEditingController playlistDescriptionController = TextEditingController();

  final TextEditingController playlistStatusController = TextEditingController();
  late bool isPublic = true;

  void createPlaylistAlertDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Center(
                child: Text(
                  'Create a playlist',
                  style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 17.sp
                  ),
                )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h,),
                CustomTextFieldUpload(
                  maxLines: 1,
                  controller: playlistTitleController,
                  fieldLabel: 'title',
                ),
                SizedBox(height: 10.h,),

                CustomTextFieldUpload(
                  maxLines: 3,
                  minLines: 1,
                  controller: playlistDescriptionController,
                  fieldLabel: 'description',
                ),
                SizedBox(height: 10.h,),

                // CustomTextFieldUpload(
                //   maxLines: 1,
                //   controller: playlistStatusController,
                //   fieldLabel: 'status',
                // ),
                // SizedBox(height: 10.h,),

                Material(
                  // borderRadius: BorderRadius.circular(15),
                  // elevation: 2,
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.tertiaryFixedDim,
                    ),
                    // padding: EdgeInsets.all(0),
                    child: CustomToggleButton(
                        borderRadius: 15.0,
                        onTap: () {
                          setState(() {
                            isPublic = !isPublic;
                          });
                        },
                        toggleName: 'Status',
                        toggleValue: isPublic,
                        onChanged: (bool value) {
                          setState(() {
                            isPublic = value;
                          });
                        },
                        toggleState: isPublic ? 'Public' : 'Private'),
                  ),
                ),

                SizedBox(height: 10.h,),

                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){
                    final playlistTitle = playlistTitleController.text;
                    final playlistDescription = playlistDescriptionController.text;
                    final playlistStatus = playlistStatusController.text;

                    context.read<CreatePlaylistBloc>().add(CreatePlaylistRequest(
                        playlistTitle: playlistTitle,
                        playlistDescription: playlistDescription,
                        playlistStatus: playlistStatus
                    ));

                    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor
                    ),
                    child: const Center(
                      child: Text(
                        'Create',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 15,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),

          );
        }
    );

  }
}
