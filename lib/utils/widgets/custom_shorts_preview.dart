import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/Config/colors.dart';

import '../../config/constants.dart';

class CustomShortsPreview extends StatelessWidget {
  final String thumbNailPath;
  final String? localImage;
  final String views;
  
  const CustomShortsPreview({
    super.key, 
    required this.thumbNailPath,
    required this.views,
    this.localImage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: red,
      height: ScreenSize.screenHeight(context) * 0.25,
      width: ScreenSize.screenWidth(context) * 0.12,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                color: greyShade500,
              ),

            height: ScreenSize.screenHeight(context) * 0.25,
            width: ScreenSize.screenWidth(context) * 0.35,
            child: thumbNailPath.isNotEmpty
                ? Image.network(thumbNailPath, fit: BoxFit.cover)
                : Image.asset(localImage!, fit: BoxFit.cover,)
          ),

          Positioned(
            bottom: 2.h,
            left: 5.w,
            child: Text('$views views', style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontFamily: fontFamily
            ),),
          )
        ],
      ),
    );
  }
}
