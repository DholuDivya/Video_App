import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';

import '../../config/constants.dart';

class CustomPlaylistPreview extends StatelessWidget {
  final String imageUrl;
  final int numberOfVideos;
  final String playlistName;
  final String channelName;
  final Function()? onShowMorePressed;

  const CustomPlaylistPreview({
    super.key,
    required this.imageUrl,
    required this.numberOfVideos,
    required this.playlistName,
    required this.channelName,
    this.onShowMorePressed
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      // height: 110,
      // width: double.infinity,
      // color: Colors.yellow,
      padding: EdgeInsets.only(
        top: ScreenSize.screenHeight(context) * 0.00,
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
                    height: 91.h,
                    width: ScreenSize.screenWidth(context) * 0.5,
                    // color: Colors.red,
                  ),

                  // BACK SIDE CONTAINER 1 ----------------------------

                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSize.screenWidth(context) * 0.05),
                    child: Container(
                      height: ScreenSize.screenHeight(context) * 0.1,
                      width: ScreenSize.screenWidth(context) * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),

                  // BACK SIDE CONTAINER 2 ----------------------------
                  Positioned(
                    top: ScreenSize.screenHeight(context) * 0.005,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSize.screenWidth(context) * 0.025),
                      child: Container(
                        height: ScreenSize.screenHeight(context) * 0.1,
                        width: ScreenSize.screenWidth(context) * 0.45,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),

                  // BACK SIDE CONTAINER 3 ----------------------
                  Positioned(
                    top: ScreenSize.screenHeight(context) * 0.011,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imageUrl.isNotEmpty
                          ? Container(
                        height: ScreenSize.screenHeight(context) * 0.12,
                        width: ScreenSize.screenWidth(context) * 0.5,
                        color: greyShade500,
                        child: Image.network(imageUrl,
                            fit: BoxFit.cover),
                      )
                          : Container(
                        height: ScreenSize.screenHeight(context) * 0.12,
                        width: ScreenSize.screenWidth(context) * 0.5,
                        decoration: BoxDecoration(
                            color: greyShade600,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Icon(HeroiconsOutline.folderOpen, size: 28, color: greyShade400,),
                        ),),
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
                          Icon(
                            Remix.play_list_line,
                            color: Colors.white,
                            size: 13,
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth(context) * 0.01,
                          ),
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
                // color: red,
                height: ScreenSize.screenHeight(context) * 0.12,
                width: ScreenSize.screenHeight(context) * 0.15,
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
            top: -4,
            right: 0,
            child: IconButton(
                onPressed: onShowMorePressed,
                icon: Icon(HeroiconsOutline.ellipsisVertical, size: 20,)
            )
          )
        ],
      ),
    );
  }
}
