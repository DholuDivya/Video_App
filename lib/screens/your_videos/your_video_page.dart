import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';

import '../../config/constants.dart';

class YourVideoPage extends StatelessWidget {
  const YourVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Videos'),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.videoData.first.channel!.videos!.length,
                    itemBuilder: (BuildContext context, int index) {

                      final videoData = state.videoData.first.channel!.videos?[index];
                      int? totalSeconds = state.videoData.first.channel!.videos?[index].duration!;
                      String formattedTime = formatDuration(totalSeconds!);

                      return CustomVideoPreview(
                          imageUrl: '${videoData?.thumbnails}',
                          videoTitle: '${videoData?.title}',
                          videoViews: '${videoData?.views}',
                          uploadTime: '${videoData?.createdAtHuman}',
                          videoDuration: formattedTime
                      );
                    },
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
