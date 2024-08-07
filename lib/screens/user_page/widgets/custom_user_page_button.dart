import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class UserPageButton extends StatelessWidget {
  final String buttonName;
  final String? subTitle;
  final IconData buttonIcon;
  final VoidCallback? onTap;

  const UserPageButton({
    super.key,
    required this.buttonName,
    this.subTitle,
    required this.buttonIcon,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return subTitle != null ? InkWell(
      onTap: onTap,
      child: Container(
        height: 55.h,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: 15.w,),
            Icon(buttonIcon),
            SizedBox(width: 20.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonName,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 17,
                  ),
                ),
                Text(
                  subTitle!,
                  style: TextStyle(
                      fontFamily: fontFamily,
                      color: greyShade500,
                    fontSize: 13.sp
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ) : InkWell(
      onTap: onTap,
      child: Container(
        height: 55.h,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: 15.w,),
            Icon(buttonIcon),
            SizedBox(width: 20.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonName,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 17,
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
    // return InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     alignment: Alignment.center,
    //     height: ScreenSize.screenHeight(context) * 0.07,
    //     child: Center(
    //       child: ListTile(
    //         leading: Icon(buttonIcon),
    //         title: Text(
    //           buttonName,
    //           style: TextStyle(
    //             fontFamily: fontFamily,
    //           ),
    //           // textAlign: TextAlign.center, // Centering the title text
    //         ),
    //         subtitle: subTitle != null
    //             ? Text(
    //           subTitle!,
    //           style: TextStyle(
    //             fontFamily: fontFamily,
    //             color: greyShade500,
    //             fontSize: 12,
    //           ),
    //           // textAlign: TextAlign.center, // Centering the subtitle text
    //         )
    //             : null,
    //       ),
    //     ),
    //   ),
    // );
  }
}
