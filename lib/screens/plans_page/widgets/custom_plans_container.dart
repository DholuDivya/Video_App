// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/colors.dart';
// import '../../../config/constants.dart';
//
// class CustomPlansContainer extends StatelessWidget {
//   final String planName;
//   final String planPrice;
//   final bool isPlanSelected;
//   final VoidCallback onTap;
//   final String timePeriod;
//
//   const CustomPlansContainer({
//     super.key,
//     required this.planName,
//     required this.planPrice,
//     required this.isPlanSelected,
//     required this.onTap,
//     required this.timePeriod
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     print('5555555555555    $isPlanSelected');
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: onTap,
//       child: Container(
//         height: 70.h,
//         width: double.infinity,
//         padding: EdgeInsets.only(
//           left: 15.w,
//           right: 12.w,
//         ),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: isPlanSelected ? Border.all(
//               width: 3.5,
//               color: primaryColor,
//             ) : Border.all(
//               width: 1.0,
//               color: greyShade400,
//             )
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   planName,
//                   style: TextStyle(
//                       fontFamily: fontFamily,
//                       fontSize: 13.sp
//                   ),
//                 ),
//
//                 Row(
//                   children: [
//                     Text(
//                       planPrice,
//                       style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     SizedBox(width: 5.w,),
//
//                     Text(
//                       '/$timePeriod',
//                       style: TextStyle(
//                         fontFamily: fontFamily,
//                       ),
//                     ),
//                   ],
//                 )
//
//               ],
//             ),
//
//
//             Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 // Icon(HeroiconsOutline.checkCircle),
//                 SizedBox(height: 8.h,),
//                 Container(
//                   height: 14.h,
//                   width: 16.w,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       border: isPlanSelected ? Border.all(
//                           width: 5.5,
//                           color: primaryColor
//                       ) : Border.all(
//                           width: 1.2,
//                           color: greyShade500
//                       )
//                   ),
//                 ),
//                 // SizedBox.shrink()
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/colors.dart';
import '../../../config/constants.dart';

class CustomPlansContainer extends StatelessWidget {
  final String planName;
  final String planPrice;
  final String timePeriod;
  final bool isPlanSelected;
  final bool isExpanded; // To manage expansion
  final VoidCallback onTap;

  const CustomPlansContainer({
    super.key,
    required this.planName,
    required this.planPrice,
    required this.timePeriod,
    required this.isPlanSelected,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isPlanSelected
              ? Border.all(
            width: 3.5,
            color: Colors.white,
          )
              : Border.all(
            width: 1.0,
            color: greyShade400,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: isExpanded ? 60.h : 50.h, // Height adjustment
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        planName,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            planPrice,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '/$timePeriod',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white60
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 8.h),
                      Container(
                        height: 14.h,
                        width: 16.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: isPlanSelected
                              ? Border.all(
                            width: 5.5,
                            color: primaryColor,
                          )
                              : Border.all(
                            width: 1.2,
                            color: greyShade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isExpanded) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    'Features:',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14.sp,
                        color: Colors.white60
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 16.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Ads free',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w200,
                          color: Colors.white60
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 16.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Access premium content',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14.sp,
                        color: Colors.white60
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 16.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Picture-in-picture',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14.sp,
                        color: Colors.white60
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
