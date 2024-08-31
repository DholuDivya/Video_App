import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomShortsPreviewHomepage extends StatelessWidget {
  final String? localImage;
  final String? thumbNailPath;
  final int? views;

  const CustomShortsPreviewHomepage({
    super.key,
    this.localImage,
    this.thumbNailPath,
    this.views
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context) * 0.5,
      width: ScreenSize.screenWidth(context) * 0.5,
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                height: ScreenSize.screenHeight(context) * 0.5,
                width: ScreenSize.screenWidth(context) * 0.5,
                decoration: BoxDecoration(
                    color: greyShade500,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: thumbNailPath!.isNotEmpty
                    ? Image.network(thumbNailPath!, fit: BoxFit.cover)
                    : Image.asset(localImage!, fit: BoxFit.cover,)
            ),
          ),

          Positioned(
            bottom: 8,
            left: 8,
            child: Text(views.toString(), style: TextStyle(
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
