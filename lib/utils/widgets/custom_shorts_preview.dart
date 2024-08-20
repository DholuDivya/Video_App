import 'package:flutter/material.dart';
import 'package:vimeo_clone/Config/colors.dart';

import '../../config/constants.dart';

class CustomShortsPreview extends StatelessWidget {
  final String thumbNailPath;
  final String views;
  
  const CustomShortsPreview({
    super.key, 
    required this.thumbNailPath,
    required this.views
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
            color: greyShade500,
            height: ScreenSize.screenHeight(context) * 0.25,
            width: ScreenSize.screenWidth(context) * 0.35,
            child: Image.network(thumbNailPath, fit: BoxFit.cover),
          ),

          Positioned(
            top: 180,
            left: 5,
            child: Text(views, style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: fontFamily
            ),),
          )
        ],
      ),
    );
  }
}
