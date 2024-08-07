import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';

class HistoryVideoPreview extends StatelessWidget {
  final String imageUrl;
  final String videoTitle;
  final String channelName;
  final String videoDuration;

  const HistoryVideoPreview({super.key,
    required this.imageUrl,
    required this.videoTitle,
    required this.channelName,
    required this.videoDuration
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context) * 0.21,
      // color: Colors.grey,
      child: ListView.builder(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.04
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.only(
                // left: ScreenSize.screenWidth(context) * 0.022,
                right: ScreenSize.screenWidth(context) * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.fill,
                          height: ScreenSize.screenHeight(context) * 0.12,
                          width: ScreenSize.screenWidth(context) * 0.5,
                        ),
                      ),

                      Positioned(
                        top: ScreenSize.screenHeight(context) * 0.09,
                        right: ScreenSize.screenWidth(context) * 0.009,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    fontSize: 13,
                                    fontFamily: fontFamily,
                                    color: Colors.grey

                                ),
                              )
                            ],
                          )
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){},
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
              ),
            );
          }
      ),
    );
  }
}
