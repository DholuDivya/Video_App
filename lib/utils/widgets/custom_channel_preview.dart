import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomChannelPreview extends StatelessWidget {
  final String channelLogo;
  final String channelName;
  final String channelSubscriber;

  const CustomChannelPreview({
    super.key,
    required this.channelLogo,
    required this.channelName,
    required this.channelSubscriber
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 50.w
      ),
      // color: red,
      height: 80.h,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 15.h,
                bottom: 15.h
            ),
            child: CircleAvatar(
              radius: 35,
              // backgroundColor: greyShade500,
              backgroundImage: NetworkImage(channelLogo)
            ),
          ),
          SizedBox(width: 10.w,),

          Padding(
            padding: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h
            ),
            child: Container(
              // padding: EdgeInsets.only(
              //   top: 10.h,
              //   bottom: 10.h
              // ),
              // color: blue,
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channelName,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15.sp
                    ),
                  ),

                  Text(
                    channelSubscriber,
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 9.sp
                    ),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
              onPressed: (){},
              icon: Icon(HeroiconsOutline.ellipsisVertical)
          )
        ],
      ),
    );
  }
}
