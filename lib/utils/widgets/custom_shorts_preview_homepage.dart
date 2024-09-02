import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomShortsPreviewHomepage extends StatelessWidget {
  final String? localImage;
  final String? thumbNailPath;
  final String? title;
  final VoidCallback? onTap;

  const CustomShortsPreviewHomepage({
    super.key,
    this.localImage,
    this.thumbNailPath,
    this.title,
    this.onTap
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
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  height: 300.h,
                  width: 168.w,
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
              bottom: 5.h,
              left: 8.w,
              right: 8.w,
              child: Text(
                  title!,
                  maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  overflow: TextOverflow.ellipsis
              )),
            )
          ],
        ),
      ),
    );
  }
}
