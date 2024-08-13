import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';

class ForYouPreview extends StatelessWidget {
  final String videoTitle;
  final String videoThumbnail;
  final String channelName;
  final String uploadTime;

  const ForYouPreview({
    super.key,
    required this.videoTitle,
    required this.channelName,
    required this.uploadTime,
    required this.videoThumbnail
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(
                right: ScreenSize.screenWidth(context) * 0.044
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ScreenSize.screenHeight(context) * 0.19,
                  width: ScreenSize.screenWidth(context) * 0.70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(videoThumbnail,
                      fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.005,),

                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenSize.screenHeight(context) * 0.085,
                        width: ScreenSize.screenWidth(context) * 0.62,
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              videoTitle,
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  // fontWeight: FontWeight.w500
                              ),
                              maxLines: 2,
                            ),
                            Text(
                              '${channelName} - ${uploadTime}',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 11,
                                  color: Colors.grey[500]
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: ScreenSize.screenHeight(context) * 0.04,
                        width: ScreenSize.screenWidth(context) * 0.08,

                        // color: Colors.blue,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: (){},
                            child: Icon(HeroiconsOutline.ellipsisVertical, size: 22,)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          );
        }

}
