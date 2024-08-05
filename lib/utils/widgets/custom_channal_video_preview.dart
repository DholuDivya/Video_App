import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomVideoPreview extends StatelessWidget {
  final String imageUrl;
  final String videoTitle;
  final String videoViews;
  final String uploadTime;
  final String videoDuration;

  const CustomVideoPreview(
      {super.key,
      required this.imageUrl,
      required this.videoTitle,
      required this.videoViews,
      required this.uploadTime,
      required this.videoDuration});

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
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          height: ScreenSize.screenHeight(context) * 0.12,
                          width: ScreenSize.screenWidth(context) * 0.45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: ScreenSize.screenHeight(context) * 0.12,
                          width: ScreenSize.screenWidth(context) * 0.45,
                          color: Colors.black.withOpacity(
                              0.5),
                        ),
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          height: ScreenSize.screenHeight(context) * 0.12,
                          width: ScreenSize.screenWidth(context) * 0.45,
                          fit: BoxFit.cover,
                        ),
                      ),

                    ],
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
              SizedBox(
                width: ScreenSize.screenWidth(context) * 0.03,
              ),

              Container(
                height: ScreenSize.screenHeight(context) * 0.12,
                width: ScreenSize.screenHeight(context) * 0.19,
                // color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoTitle,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 3,
                    ),
                    Text(
                      '${videoViews} views - ${uploadTime}',
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 10,
                          color: Colors.grey[500]),
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
              onTap: () {},
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 35,
                width: 35,
                // color: Colors.green,
                child: Center(
                    child: Icon(
                  HeroiconsOutline.ellipsisVertical,
                  size: 20,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
