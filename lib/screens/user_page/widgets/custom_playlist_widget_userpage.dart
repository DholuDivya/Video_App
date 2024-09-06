import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomPlaylistWidgetUserPage extends StatelessWidget {
  final int numberOfVideos;
  final String imageUrl;
  final String playlistTitle;
  final String playlistVisibility;
  final Function()? onShowMorePressed;

  const CustomPlaylistWidgetUserPage({
    super.key,
    required this.numberOfVideos,
    required this.imageUrl,
    required this.playlistTitle,
    required this.playlistVisibility,
    this.onShowMorePressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: blue,
        height: 150.h,
        width: 180.w,
        child: Column(children: [
          Stack(
              children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: ScreenSize.screenHeight(context) * 0.135,
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
                                    color: greyShade500,
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
              ],
            ),
          ]),


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: blue,
                  width: 144.w,
                  height: 50.h,
                  padding: EdgeInsets.only(left: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlistTitle,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: fontFamily,
                            overflow: TextOverflow.ellipsis
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        playlistVisibility,
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
                onTap: onShowMorePressed,
                child: Container(
                  height: ScreenSize.screenHeight(context) * 0.045,
                  width: ScreenSize.screenWidth(context) * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),

                  ),
                  child: const Icon(HeroiconsOutline.ellipsisVertical, size: 20,),
                ),
              )
            ],
          )

          // Container(
          //   height: 30.h,
          //   width: double.infinity,
          //   // color: green,
          //   child: Row(
          //     // mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         color: yellow,
          //         height: 30.h,
          //           width: 144.w,
          //           padding: EdgeInsets.only(
          //             left: 5.w
          //           ),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 playlistTitle,
          //                 style: TextStyle(
          //                   fontFamily: fontFamily,
          //                   fontSize: 15
          //                 ),
          //               ),
          //             ],
          //           )
          //       ),
          //
          //       InkWell(
          //         borderRadius: BorderRadius.circular(100),
          //         onTap: (){},
          //         child: Container(
          //           height: ScreenSize.screenHeight(context) * 0.045,
          //           width: ScreenSize.screenWidth(context) * 0.1,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(100),
          //
          //           ),
          //           child: Icon(HeroiconsOutline.ellipsisVertical, size: 20,),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //
          // Container(
          //   height: 20.h,
          //   width: double.infinity,
          //   color: Colors.indigo,
          //   child: Text(
          //     playlistVisibility,
          //     style: TextStyle(
          //         fontFamily: fontFamily,
          //         fontSize: 13,
          //         color: greyShade500
          //     ),
          //   ),
          // )


        ])
    );
  }
}
