import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';
import 'package:vimeo_clone/utils/widgets/toggle_button.dart';
import '../../bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import '../../bloc/add_video_to_playlist/add_video_playlist_event.dart';
import '../../bloc/add_video_to_playlist/add_video_playlist_state.dart';
import '../../bloc/create_playlist/create_playlist_bloc.dart';
import '../../bloc/create_playlist/create_playlist_event.dart';
import '../../bloc/get_user_playlist/get_user_playlist_bloc.dart';
import '../../bloc/get_user_playlist/get_user_playlist_event.dart';
import '../../bloc/get_user_playlist/get_user_playlist_state.dart';
import '../../bloc/playlist_selection/playlist_selection_bloc.dart';
import '../../bloc/playlist_selection/playlist_selection_event.dart';
import '../../bloc/playlist_selection/playlist_selection_state.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';

class PlaylistBottomSheet extends StatefulWidget {
  final int videoId;
  final String userChannelId;

  const PlaylistBottomSheet({
    super.key,
    required this.videoId,
    required this.userChannelId,
  });

  @override
  State<PlaylistBottomSheet> createState() => _PlaylistBottomSheetState();
}

class _PlaylistBottomSheetState extends State<PlaylistBottomSheet> {
  late int playlistLength = 0;
  List<int> selectedPlaylistIds = [];
  late int selectedPlaylist;
  final TextEditingController playlistTitleController = TextEditingController();
  final TextEditingController playlistDescriptionController = TextEditingController();
  late String playlistStatus = 'public';
  late bool isPublic = true;

  @override
  Widget build(BuildContext context) {




    context.read<GetUserPlaylistBloc>().add(
        GetUserPlaylistRequest(channelId: int.parse(widget.userChannelId)));
    final playlistBloc = context.read<GetUserPlaylistBloc>();
    playlistBloc.stream.listen((state) {
      if (state is GetUserPlaylistSuccess) {
        // Playlist length logic
        playlistLength = state.userPlaylist.length;
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        SaveToPlaylistHeader(context),
        PlaylistListWidget(context),
        AddToPlaylistButton(context),
      ],
    );
  }

  Widget SaveToPlaylistHeader(BuildContext context){
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: greyShade300
              )
          )
      ),
      padding: EdgeInsets.only(
          top: 5.h,
          left: 10.w,
          right: 10.w,
          bottom: 2.h
      ),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Save to...',
            style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16
            ),
          ),

          MaterialButton(
            onPressed: (){
              createPlaylistAlertDialog();
            },
            child: Text(
              '+ Create playlist',
              style: TextStyle(
                  fontFamily: fontFamily,
                  color: primaryColor
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget PlaylistListWidget(BuildContext context) {
    return BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
      builder: (BuildContext context, GetUserPlaylistState state) {
        if (state is GetUserPlaylistSuccess) {
          final playlistLength = state.userPlaylist.length;
          final playlist = state.userPlaylist;

          return BlocBuilder<PlaylistSelectionBloc, PlaylistSelectionState>(
            builder: (BuildContext context, PlaylistSelectionState selectionState) {
              print('STATE :::   $selectionState');

              // Get selected playlist IDs from the Bloc stat
              if (selectionState is PlaylistSelected) {
                selectedPlaylistIds = selectionState.selectedPlaylistIds;
              }

              return SizedBox(
                height: 150.h, // Use SizedBox instead of Expanded here
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!state.hasReachedMax &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      context.read<GetUserPlaylistBloc>().add(LoadMoreUserPlaylist());
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.h),
                    shrinkWrap: true,
                    itemCount: state.hasReachedMax
                        ? state.userPlaylist.length
                        : state.userPlaylist.length + 1,
                    itemBuilder: (context, index) {
                      final userPlaylist = playlist[index];
                      final isSelected = selectedPlaylistIds.contains(userPlaylist.id);

                      return Container(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          bottom: 4.h,
                        ),
                        width: double.infinity,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            if (isSelected) {
                              context.read<PlaylistSelectionBloc>().add(
                                  DeselectPlaylistRequest(playlistId: userPlaylist.id!));
                            } else {
                              context.read<PlaylistSelectionBloc>().add(
                                  SelectPlaylistRequest(playlistId: userPlaylist.id!));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isSelected ? blue : Theme.of(context).colorScheme.tertiaryFixedDim,
                            ),
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${userPlaylist.title}',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  '${userPlaylist.videos!.length}',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }


  // Widget PlaylistListWidget(BuildContext context){
  //   return BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
  //     builder: (BuildContext context, GetUserPlaylistState state) {
  //       if(state is GetUserPlaylistSuccess){
  //         final playlistLength = state.userPlaylist.length;
  //         final playlist = state.userPlaylist;
  //         return BlocBuilder<PlaylistSelectionBloc, PlaylistSelectionState>(
  //           builder: (BuildContext context, PlaylistSelectionState state) {
  //             print('STATE :::   $state');
  //             if(state is PlaylistSelected){
  //               selectedPlaylistIds = state.selectedPlaylistIds;
  //               selectedPlaylist = selectedPlaylistIds.first;
  //             }
  //             return Container(
  //               height: 150.h,
  //               child: Expanded(
  //                 child: NotificationListener<ScrollNotification>(
  //
  //                   child: ListView.builder(
  //                     padding: EdgeInsets.only(
  //                       top: 10.h
  //                     ),
  //                     shrinkWrap: true,
  //                     itemCount: playlistLength,
  //                     itemBuilder: (context, index) {
  //                       final userPlaylist = playlist[index];
  //                       final isSelected =  selectedPlaylistIds.contains(userPlaylist.id);
  //                       return Container(
  //                         padding: EdgeInsets.only(
  //                           // top: 2.h,
  //                             left: 10.w,
  //                             right: 10.w,
  //                             bottom: 4.h
  //                         ),
  //                         width: double.infinity,
  //
  //                         child: InkWell(
  //                           borderRadius: BorderRadius.circular(15),
  //                           onTap: () {
  //                             if(isSelected){
  //                               context.read<PlaylistSelectionBloc>().add(DeselectPlaylistRequest(playlistId: userPlaylist.id!));
  //                             } else {
  //                               context.read<PlaylistSelectionBloc>().add(SelectPlaylistRequest(playlistId: userPlaylist.id!));
  //                             }
  //                           },
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 30.h,
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: isSelected
  //                                   ? blue
  //                                   : Theme.of(context).colorScheme.tertiaryFixedDim,
  //                             ),
  //                             padding: EdgeInsets.only(left: 20.w, right: 20.w),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Text(
  //                                   '${userPlaylist.title}',
  //                                   style: TextStyle(
  //                                       fontFamily: fontFamily,
  //                                       color: isSelected ? Colors.white : Colors.black
  //                                   ),
  //                                 ),
  //
  //                                 Text(
  //                                   '${userPlaylist.videos!.length}',
  //                                   style: TextStyle(
  //                                       fontFamily: fontFamily,
  //                                       color: isSelected ? Colors.white : Colors.black
  //                                   ),
  //                                 ),
  //
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       }
  //       return const Center(child: CircularProgressIndicator(),);
  //     },
  //   );
  // }

  Widget AddToPlaylistButton(BuildContext context) {

    return BlocBuilder<AddVideoToPlaylistBloc, AddVideoToPlaylistState>(
      builder: (BuildContext context, AddVideoToPlaylistState state) {
        if (state is AddVideoToPlaylistSuccess) {
          ToastManager().showToast(
            context: context,
            message: state.message,
          );
          Navigator.pop(context);
        }
        return InkWell(
          onTap: () {
            if(selectedPlaylistIds.isEmpty){
              ToastManager().showToast(
                  context: context,
                  message: 'Please select at least one playlist'
              );
            }else{
              context.read<AddVideoToPlaylistBloc>().add(AddVideoToPlaylistRequest(
                videoId: widget.videoId,
                playlistIds: selectedPlaylistIds,
              ));
            }

          },
          child: Container(
            height: 40.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: greyShade300),
              ),
            ),
            child: const Center(
              child: Text(
                'Done',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  void createPlaylistAlertDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState){
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
                  content: SizedBox(
                    width: 400.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8.h,),
                        CustomTextFieldUpload(
                          readOnly: false,
                          isEnabled: true,
                          maxLines: 1,
                          controller: playlistTitleController,
                          fieldLabel: 'title',
                        ),
                        SizedBox(height: 10.h,),

                        CustomTextFieldUpload(
                          readOnly: false,
                          isEnabled: true,
                          maxLines: 3,
                          minLines: 1,
                          controller: playlistDescriptionController,
                          fieldLabel: 'description',
                        ),
                        SizedBox(height: 10.h,),

                        Material(
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
                                    if(isPublic){
                                      playlistStatus = 'public';
                                    }else{
                                      playlistStatus = 'private';
                                    }
                                    print('STATUSSSSSSSSS   :::::::    $playlistStatus');
                                  });
                                },
                                toggleName: 'Privacy',
                                toggleValue: isPublic,
                                onChanged: (bool value) {
                                  setState(() {
                                    isPublic = value;
                                    print('STATUSSSSSSSSS   :::::::    $isPublic');
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

                            context.read<CreatePlaylistBloc>().add(CreatePlaylistRequest(
                                playlistTitle: playlistTitle,
                                playlistDescription: playlistDescription,
                                playlistStatus: playlistStatus
                            ));

                            Navigator.pop(context);
                            context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(widget.userChannelId)));
                          },
                          child: Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor
                            ),
                            child: Center(
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
                  ),
                );
              });
        }
    ).whenComplete((){
      context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(widget.userChannelId)));
    });
  }
}