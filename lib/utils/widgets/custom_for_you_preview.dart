import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/Config/constants.dart';

class ForYouPreview extends StatelessWidget {
  final String videoTitle;
  // final String videoThumbnail;
  final String channelName;
  final String uploadTime;

  const ForYouPreview({
    super.key,
    required this.videoTitle,
    required this.channelName,
    required this.uploadTime
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenSize.screenHeight(context) * 0.28,
        // color: Colors.yellow,
        child: ListView.builder(
          shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            padding: EdgeInsets.only(
                left: ScreenSize.screenWidth(context) * 0.044
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: ScreenSize.screenWidth(context) * 0.044
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenSize.screenHeight(context) * 0.2,
                      width: ScreenSize.screenWidth(context) * 0.8,
                      // color: Colors.green,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/jethalal.jpg',
                          fit: BoxFit.fill,),
                      ),
                    ),

                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: ScreenSize.screenHeight(context) * 0.08,
                            width: ScreenSize.screenWidth(context) * 0.72,
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  videoTitle,
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 2,
                                ),
                                Text(
                                  '${channelName} - ${uploadTime}',
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 11,
                                      color: Theme.of(context).colorScheme.tertiary
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
        )
    );
  }
}
