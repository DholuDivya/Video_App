import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_history_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/shimmer.dart';

class UserHistoryWidget extends StatefulWidget {
  const UserHistoryWidget({super.key});

  @override
  State<UserHistoryWidget> createState() => _UserHistoryWidgetState();
}

class _UserHistoryWidgetState extends State<UserHistoryWidget> {

  late int historyLength;

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
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    onPressed: (){
                      GoRouter.of(context).pushNamed('allHistoryPage');
                    },
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
                      final totalSeconds = userHistory.duration;
                      final formattedDuration = formatDuration(totalSeconds!);
                        return Padding(
                          padding: EdgeInsets.only(
                            // left: ScreenSize.screenWidth(context) * 0.022,
                            right: ScreenSize.screenWidth(context) * 0.04,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: (){
                              Future.delayed(const Duration(milliseconds: 100), (){
                                GoRouter.of(context).pushNamed('videoPage',
                                    pathParameters: {
                                      "slug": userHistory.slug!
                                    });
                              });
                            },
                            child: HistoryVideoPreview(
                                imageUrl: '${userHistory.thumbnail}',
                                videoTitle: '${userHistory.title}',
                                channelName: '${userHistory.channel!.name}',
                                videoDuration: formattedDuration
                            ),
                          ),
                        );
                  }),
                );

              }
              // return Container();
              return Container(
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      left: ScreenSize.screenWidth(context) * 0.04
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w
                      ),
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
    );
  }
}

