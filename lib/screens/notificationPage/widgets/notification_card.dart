import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class NotificationCard extends StatelessWidget {
  final String channelProfile;
  final String videoTitle;
  final String uploadTime;
  final String videoThumbnail;
  final Function()? onTap;
  final Function()? onChannelTap;

  const NotificationCard({
    super.key,
    required this.videoTitle,
    required this.uploadTime,
    required this.videoThumbnail,
    required this.channelProfile,
    this.onTap,
    this.onChannelTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: ScreenSize.screenHeight(context) * 0.012,
                left: 15.h
            ),
            // color: Colors.grey,
            height: ScreenSize.screenHeight(context) * 0.12,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onChannelTap,
                  child: CircleAvatar(
                    radius: 18,
                    // backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(channelProfile),
                  ),
                ),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.02,),

                Container(
                  // color: Colors.red,
                  height: ScreenSize.screenHeight(context) * 0.11,
                  // height: 85,
                  width: ScreenSize.screenWidth(context) * 0.41,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(videoTitle,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: fontFamily,
                            overflow: TextOverflow.ellipsis
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: ScreenSize.screenHeight(context) * 0.001,),
                      Text(
                        uploadTime,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                            fontFamily: fontFamily
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),


                Container(
                  height: ScreenSize.screenHeight(context) * 0.085,
                  width: ScreenSize.screenWidth(context) * 0.33,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(videoThumbnail, fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -5.h,
              // top: 1.h,
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(HeroiconsOutline.ellipsisVertical, size: 20.r,)
              )
          ),
        ],
      ),
    );
  }
}
