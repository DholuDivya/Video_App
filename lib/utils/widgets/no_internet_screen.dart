import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: red,
              child: SvgPicture.asset(
                'assets/images/no_connection.svg',
                height: 200.h,
                width: 300.w,
              )
          ),
          // Text(
          //   'No Internet',
          //   style: TextStyle(
          //       fontFamily: fontFamily,
          //       fontSize: 15.sp
          //   ),
          // ),
        ],
      ),),
    );
  }
}
