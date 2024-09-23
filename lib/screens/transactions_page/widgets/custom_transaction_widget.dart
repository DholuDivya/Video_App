import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';

class CustomTransactionWidget extends StatelessWidget {
  const CustomTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.w
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 0.5
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage('${Global.userData!.userProfilePhoto}'),
                  ),
                  SizedBox(width: 10.w,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Ruth Henry',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      

                      Row(
                        children: [
                          Icon(Remix.circle_fill, size: 10.r, color: green,),
                          SizedBox(width: 5.w,),
                          Text(
                              'Success  -  12 Sept 2024',
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.primaryFixedDim
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

            Container(
              child: Text(
                  '200/-',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
