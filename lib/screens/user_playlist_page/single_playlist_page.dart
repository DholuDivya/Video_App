import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

import '../../utils/widgets/custom_channal_video_preview.dart';

class SinglePlaylistPage extends StatelessWidget {
  const SinglePlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyShade300,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(HeroiconsOutline.ellipsisVertical)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 255.h,
              width: double.infinity,
              decoration: BoxDecoration(

                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(20),
                //   topRight: Radius.circular(20),
                //
                // ),
                color: greyShade300,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 20.w,
                      right: 20.w,
                      bottom: 20.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 16/9,
                            child: Image.asset('assets/images/jethalal.jpg', fit: BoxFit.contain,),
                          ),
                        ),
                        SizedBox(height: 10.h,),

                        Text(
                          'Playlist Name',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 17
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Channel Name',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 12
                                  ),
                                ),
                                Text(
                                  '4 videos  -  Public',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 10,
                                    color: greyShade700
                                  ),
                                )
                              ],
                            ),

                            InkWell(
                              onTap: (){},
                              child: Container(
                                height: 30.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white.withOpacity(0.4)
                                ),
                                child: const Icon(HeroiconsOutline.pencilSquare, size: 20,),
                              ),
                            )
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
                color: Colors.white
              ),
              padding: EdgeInsets.only(top: 10.h),
              child: BlocBuilder<GetUserHistoryBloc, GetUserHistoryState>(
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
