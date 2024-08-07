import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';

import '../../config/constants.dart';

class CustomPlaylistPreview extends StatelessWidget {
  final String imageUrl;
  final int numberOfVideos;
  final String playlistName;
  final String channelName;

  const CustomPlaylistPreview({
    super.key,
    required this.imageUrl,
    required this.numberOfVideos,
    required this.playlistName,
    required this.channelName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      // width: double.infinity,
      // color: Colors.yellow,
      padding: EdgeInsets.only(
        top: ScreenSize.screenHeight(context) * 0.015,
        left: ScreenSize.screenWidth(context) * 0.03,
        // right: ScreenSize.screenWidth(context) * 0.02,
        // bottom: ScreenSize.screenHeight(context) * 0.01
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Stack(
                children: [
                  Container(
                    height: ScreenSize.screenHeight(context) * 0.15,
                    width: ScreenSize.screenWidth(context) * 0.45,
                    // color: Colors.red,
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSize.screenWidth(context) * 0.05
                    ),
                    child: Container(
                      height: ScreenSize.screenHeight(context) * 0.1,
                      width: ScreenSize.screenWidth(context) * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),


                  // BACK SIDE CONTAINER 1 ----------------------------
                  Positioned(
                    top: ScreenSize.screenHeight(context) * 0.006,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ScreenSize.screenWidth(context) * 0.025
                      ),
                      child: Container(
                        height: ScreenSize.screenHeight(context) * 0.1,
                        width: ScreenSize.screenWidth(context) * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                  
                  // BACK SIDE CONTAINER 2 ----------------------
                  Positioned(
                    top: ScreenSize.screenHeight(context) * 0.012,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                          imageUrl,
                          height: ScreenSize.screenHeight(context) * 0.12,
                          width: ScreenSize.screenWidth(context) * 0.45,
                          fit: BoxFit.cover),
                    ),
                  ),
                  
                  
                  // NUMBER OF VIDEOS IN THE PLAYLIST ------------------
                  Positioned(
                    top: ScreenSize.screenHeight(context) * 0.1,
                    right: ScreenSize.screenWidth(context) * 0.015,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.screenWidth(context) * 0.012,
                        vertical: ScreenSize.screenHeight(context) * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Remix.play_list_line, color: Colors.white, size: 13,),
                          SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),
                          Text(
                            numberOfVideos.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(width: ScreenSize.screenWidth(context) * 0.03,),

              Container(
                height: ScreenSize.screenHeight(context) * 0.12,
                width: ScreenSize.screenHeight(context) * 0.19,
                // color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(playlistName,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,

                      ),
                      maxLines: 3,
                    ),
                    Text(channelName,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 10,
                          color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),

            ],
          ),

          Positioned(
            top: 0,
            right: 5,
            child: InkWell(
              onTap: (){},
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 35,
                width: 35,
                // color: Colors.green,
                child: Center(child: Icon(HeroiconsOutline.ellipsisVertical, size: 20,)),
              ),
            ),
          )
        ],
      ),
    );;
  }
}
