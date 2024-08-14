import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/config/constants.dart';

import '../../utils/widgets/custom_channal_video_preview.dart';

class AllHistoryPage extends StatelessWidget {
  const AllHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'History',
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetUserHistoryBloc, GetUserHistoryState>(
                builder: (context, state){
                  if(state is GetUserHistorySuccess){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // padding: EdgeInsets.only(
                      //   top: ScreenSize.screenHeight(context) * 0.01,
                      // ),
                      itemCount: state.userHistory.first.data!.length,
                        itemBuilder: (context, index){
                          final userHistory = state.userHistory.first.data![index];
                          final totalSeconds = userHistory.duration;
                          final formattedDuration = formatDuration(totalSeconds!);
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
                              ),
                            ),
                          );
                        }
                    );

                  }
                  return Container();
            })
          ],
        ),
      ),
    );
  }
}
