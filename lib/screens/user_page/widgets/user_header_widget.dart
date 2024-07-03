import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context) * 0.12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.04,
              right: ScreenSize.screenWidth(context) * 0.04,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/sonysab.jpg',
                fit: BoxFit.cover,
                height: ScreenSize.screenHeight(context) * 0.1,
                width: ScreenSize.screenHeight(context) * 0.1,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Sony Sab',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 25
                )
              ),

                Row(
                  children: [
                    Text(
                      'View channel ',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Colors.grey
                      )
                    ),
                    Icon(HeroiconsOutline.chevronRight, size: 15, color: Colors.grey)
                  ],
                ),
            ],
          )
        ],
      )
        // title: Text(
        //   'User Name',
        //   style: TextStyle(
        //     fontFamily: fontFamily,
        //     fontSize: 25
        //   )
        // ),
        // subtitle: Row(
        //   children: [
        //     Text(
        //       'View channel ',
        //       style: TextStyle(
        //         fontFamily: fontFamily,
        //         color: Colors.grey
        //       )
        //     ),
        //     Icon(HeroiconsOutline.chevronRight, size: 15, color: Colors.grey)
        //   ],
        // ),


    );
  }
}
