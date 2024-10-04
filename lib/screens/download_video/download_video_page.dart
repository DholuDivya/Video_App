import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vimeo_clone/utils/widgets/custom_download_video_preview.dart';
import '../../config/constants.dart';
import '../../model/hive_model/downloaded_video_model/downloaded_video_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadedVideosPage extends StatefulWidget {
  const DownloadedVideosPage({super.key});

  @override
  _DownloadedVideosPageState createState() => _DownloadedVideosPageState();
}

class _DownloadedVideosPageState extends State<DownloadedVideosPage> {
  late Box<DownloadedVideoModel> videoBox;

  @override
  void initState() {
    super.initState();
    openVideoBox();
  }

  Future<void> openVideoBox() async {
    videoBox = await Hive.openBox<DownloadedVideoModel>('videos');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.downloads),
      ),
      body: videoBox == null || !videoBox.isOpen // Check if videoBox is initialized and open
          ? Center(
        child: CircularProgressIndicator(), // Show a loading indicator while videoBox is being initialized
      )
          :videoBox.isEmpty
          ? Container(
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
                    AppLocalizations.of(context)!.noVideosDownloadedYet,
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15.sp
                    ),
                  ),
                ],
                ),)
              )
          : ValueListenableBuilder(
        valueListenable: videoBox.listenable(),
        builder: (context, Box<DownloadedVideoModel> box, _) {
          if (box.isEmpty) {
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
                      AppLocalizations.of(context)!.noVideosDownloadedYet,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15.sp
                      ),
                    ),
                  ],
                ),)
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                DownloadedVideoModel video = box.getAt(index)!;


                return Padding(
                  padding: const EdgeInsets.only(
                    // top: 10.h
                  ),
                  child: CustomDownloadVideoPreview(
                    onTap: (){
                      Future.delayed(const Duration(milliseconds: 200), () {
                        GoRouter.of(context).pushNamed('playDownloadedVideo', extra: video);
                      });
                    },
                      onShowMorePressed: () async {
                        await box.deleteAt(index);
                      },
                      imageUrl: video.videoThumbnail!,
                      videoTitle: video.videoTitle!,
                      videoViews: video.videoViews!,
                      uploadTime: video.videoCreateAtHuman!,
                      videoDuration: video.videoDuration!
                  ),
                );

              },
            );
          }
        },
      ),
    );
  }
}
