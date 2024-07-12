import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class NotificationCard extends StatelessWidget {
  final Image? channelProfile;
  final String videoTitle;
  final String uploadTime;
  final Image? videoThumbnail;

  const NotificationCard({
    super.key,
    required this.videoTitle,
    required this.uploadTime,
    this.videoThumbnail,
    this.channelProfile
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenSize.screenHeight(context) * 0.012,
          left: ScreenSize.screenWidth(context) * 0.02
      ),
      // color: Colors.grey,
      height: ScreenSize.screenHeight(context) * 0.12,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            // backgroundColor: Colors.blue,
            backgroundImage: AssetImage('assets/images/tmkoc10.jpg'),
          ),
          SizedBox(width: ScreenSize.screenWidth(context) * 0.02,),

          Container(
            // color: Colors.red,
            height: ScreenSize.screenHeight(context) * 0.11,
            // height: 85,
            width: ScreenSize.screenWidth(context) * 0.45,
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
                  '${uploadTime} ago',
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
              child: Image.asset('assets/images/tmkoc4.jpg', fit: BoxFit.fill),
            ),
          ),

          Container(
            // color: Colors.orange,
            height: ScreenSize.screenHeight(context) * 0.03,
            width: ScreenSize.screenWidth(context) * 0.07,
            
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: (){},
              child: Center(
                  child: Icon(Remix.more_2_fill, size: 15,)
              ),
            ),
          ),

        ],
      ),
    );
  }
}
