import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_user_page_button.dart';
import 'package:vimeo_clone/utils/widgets/custom_history_video_preview.dart';

class UserHistoryWidget extends StatelessWidget {
  const UserHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.04,
              right: ScreenSize.screenWidth(context) * 0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'History',
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
                    onPressed: (){},
                  child: const Text(
                      'View all',
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
              if(state is GetUserHistorySuccess){
                return Container(
                  height: ScreenSize.screenHeight(context) * 0.21,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: ScreenSize.screenWidth(context) * 0.04
                      ),
                    itemCount: state.userHistory.first.data!.length,
                      itemBuilder: (context, index){
                      final userHistory = state.userHistory.first.data![index];
                        return HistoryVideoPreview(
                            imageUrl: '${userHistory.thumbnail}',
                            videoTitle: '${userHistory.title}',
                            channelName: '${userHistory.channel!.name}',
                            videoDuration: userHistory.duration.toString()
                        );
                  }),
                );

              }
              return HistoryVideoPreview(
                  imageUrl: 'assets/images/jethalal.jpg',
                  videoTitle: 'Tarak Mehta ka Ooltah Chashma - Episode 732',
                  channelName: 'Sony Sab',
                  videoDuration: '25:49'
              );
            },
          ),

          SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),

        ],
    );
  }
}

