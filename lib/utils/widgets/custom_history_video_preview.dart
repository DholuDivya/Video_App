import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/app/MyApp.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class HistoryVideoPreview extends StatelessWidget {
  final String imageUrl;
  final String videoTitle;
  final String channelName;
  final String videoDuration;
  final Function()? onMorePressed;

  const HistoryVideoPreview({super.key,
    required this.imageUrl,
    required this.videoTitle,
    required this.channelName,
    required this.videoDuration,
    this.onMorePressed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: ScreenSize.screenHeight(context) * 0.12,
              width: ScreenSize.screenWidth(context) * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: greyShade300,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: ScreenSize.screenHeight(context) * 0.09,
              right: ScreenSize.screenWidth(context) * 0.02,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.screenWidth(context) * 0.012,
                  vertical: ScreenSize.screenHeight(context) * 0.004,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  videoDuration,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

                width: ScreenSize.screenWidth(context) * 0.4,
                height: ScreenSize.screenHeight(context) * 0.09,
                padding: EdgeInsets.only(left: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h,),
                    Text(
                      videoTitle,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: fontFamily,
                          overflow: TextOverflow.ellipsis
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      channelName,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: fontFamily,
                          color: Colors.grey

                      ),
                    )
                  ],
                )
            ),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: onMorePressed,
              child: Container(
                height: ScreenSize.screenHeight(context) * 0.045,
                width: ScreenSize.screenWidth(context) * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),

                ),
                child: Icon(HeroiconsOutline.ellipsisVertical, size: 20,),
              ),
            )
          ],
        )
      ],
    );
        }
}
