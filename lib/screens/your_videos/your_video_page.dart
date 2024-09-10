import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_channel_video_preview.dart';
import '../../config/constants.dart';

class YourVideoPage extends StatelessWidget {
  const YourVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Videos'),
        ),
      body: BlocBuilder<YourVideosBloc, YourVideosState>(
        builder: (BuildContext context, YourVideosState state) {
          if(state is YourVideosLoading){
            return ListView.builder(
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 5.h,
                      bottom: 5.h,
                      left: 10.w,
                      right: 10.w
                  ),
                  child: ShimmerWidget.rectangular(
                      height: 100.h,
                      isBorder: true
                  ),
                );
              },
            );
          }else if(state is YourVideosLoaded){
            final length = state.videoData.first.channel.videos.length;
            return SingleChildScrollView(
              child: Column(
                children: [
                  length != 0 ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.videoData.first.channel.videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final videoCount = state.videoData.first.videoCount;
                      final videoData = state.videoData.first.channel.videos[index];
                      final videoType = videoData.type;
                      int? totalSeconds = state.videoData.first.channel.videos[index].duration;
                      String formattedTime = formatDuration(totalSeconds);
                      return videoType == 'video' ? InkWell(
                        onTap: (){
                          Future.delayed(const Duration(milliseconds: 200), () {
                            GoRouter.of(context).pushNamed('videoPage', pathParameters: {
                              "slug": videoData.slug
                            });
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                              top: 5.h,
                              bottom: 5.h
                            ),
                            child: CustomVideoPreview(
                                imageUrl: videoData.thumbnails,
                                videoTitle: videoData.title,
                                videoViews: '${videoData.views}',
                                uploadTime: videoData.createdAtHuman,
                                videoDuration: formattedTime
                            ),
                          ),
                      ) : Container();
                    },
                  ) : Padding(
                    padding: EdgeInsets.only(top: 150.h),
                    child: Center(
                        child: Image.asset(
                          'assets/images/no_data.png',
                          width: 200.w,
                          height: 200.h,
                        )),
                  )
                ],
              ),
            );
          }
          return Container();
        },

      )
    );
  }
}
