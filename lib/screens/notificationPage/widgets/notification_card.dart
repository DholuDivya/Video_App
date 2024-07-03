import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class NotificationCard extends StatelessWidget {
  final Image? userProfile;
  final String videoTitle;
  final String channelName;
  final Image? videoThumbnail;

  const NotificationCard({
    super.key,
    this.userProfile,
    required this.videoTitle,
    required this.channelName,
    this.videoThumbnail
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenSize.screenHeight(context) * 0.012,
          left: ScreenSize.screenWidth(context) * 0.02
      ),
      // color: Colors.grey,
      height: 95,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue,
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
                Text(channelName,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontFamily: fontFamily
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),


          // Stack(
          //   children: [
          //     Container(
          //       height: ScreenSize.screenHeight(context) * 0.0,
          //       child:


          Container(
            height: ScreenSize.screenHeight(context) * 0.085,
            width: ScreenSize.screenWidth(context) * 0.33,
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12)
            ),
          ),

          Container(
            // color: Colors.orange,
            height: 25,
            width: 25,
            child: InkWell(

              child: Center(
                  child: Icon(Remix.more_2_fill, size: 15,)
              ),
            ),
          ),

          // ),



          //   ],
          // ),


        ],
      ),
    );
  }
}
