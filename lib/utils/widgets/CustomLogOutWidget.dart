import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomLogOutWidget extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;
  final IconData? icon;

  const CustomLogOutWidget({
    super.key,
    required this.btnName,
    required this.onTap,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.05,
              right: ScreenSize.screenWidth(context) * 0.05
          ),
          height: ScreenSize.screenHeight(context) * 0.070,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 25,),
                  SizedBox(width: ScreenSize.screenWidth(context) * 0.04,),
                  Text(btnName, style: const TextStyle(fontFamily: fontFamily, fontSize: 16),),
                ],
              ),

              // Icon(Remix.arrow_drop_right_line, size: 30, color: Colors.grey,)
            ],
          )
      ),
    );
  }
}
