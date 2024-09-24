// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/colors.dart';
// import '../../../config/constants.dart';
//
// class CustomPlansContainer extends StatelessWidget {
//   final String planName;
//   final String planPrice;
//   final String timePeriod;
//   final bool isPlanSelected;
//   final bool isExpanded;
//   final VoidCallback onTap;
//   final List<String> feature;
//
//   const CustomPlansContainer({
//     super.key,
//     required this.planName,
//     required this.planPrice,
//     required this.timePeriod,
//     required this.isPlanSelected,
//     required this.isExpanded,
//     required this.onTap,
//     required this.feature,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         padding: EdgeInsets.symmetric(horizontal: 15.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: isPlanSelected
//               ? Border.all(
//             width: 3.5,
//             color: Colors.white,
//           )
//               : Border.all(
//             width: 1.0,
//             color: greyShade400,
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: isExpanded ? 70.h : 80.h, // Height adjustment
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         planName,
//                         style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             planPrice,
//                             style: TextStyle(
//                               fontFamily: fontFamily,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.white
//                             ),
//                           ),
//                           SizedBox(width: 5.w),
//                           Text(
//                             '/$timePeriod',
//                             style: TextStyle(
//                               fontFamily: fontFamily,
//                               color: Colors.white60
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(height: 8.h),
//                       Container(
//                         height: 14.h,
//                         width: 16.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           border: isPlanSelected
//                               ? Border.all(
//                             width: 5.5,
//                             color: primaryColor,
//                           )
//                               : Border.all(
//                             width: 1.2,
//                             color: greyShade500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             TextButton(
//                 onPressed: (){},
//                 child: Text('Show benefits'),
//             ),
//
//
//             if (isExpanded) ...[
//               SizedBox(height: 10.h),
//               Row(
//                 children: [
//                   Text(
//                     'Features:',
//                     style: TextStyle(
//                       fontFamily: fontFamily,
//                       fontSize: 14.sp,
//                         color: Colors.white60
//                       // fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.h,),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: feature.length,
//                   itemBuilder: (BuildContext context, int index){
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.check, color: Colors.green, size: 16.0),
//                           SizedBox(width: 8.0),
//                           Text(
//                             feature[index],
//                             style: TextStyle(
//                                 fontFamily: fontFamily,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w200,
//                                 color: Colors.white60
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//               ),
//
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 4.0),
//               //   child: Row(
//               //     children: [
//               //       const Icon(Icons.check, color: Colors.green, size: 16.0),
//               //       SizedBox(width: 8.0),
//               //       Text(
//               //         'Ads free',
//               //         style: TextStyle(
//               //           fontFamily: fontFamily,
//               //           fontSize: 14.sp,
//               //           fontWeight: FontWeight.w200,
//               //             color: Colors.white60
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 4.0),
//               //   child: Row(
//               //     children: [
//               //       const Icon(Icons.check, color: Colors.green, size: 16.0),
//               //       const SizedBox(width: 8.0),
//               //       Text(
//               //         'Access premium content',
//               //         style: TextStyle(
//               //           fontFamily: fontFamily,
//               //           fontSize: 14.sp,
//               //           color: Colors.white60
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 4.0),
//               //   child: Row(
//               //     children: [
//               //       const Icon(Icons.check, color: Colors.green, size: 16.0),
//               //       const SizedBox(width: 8.0),
//               //       Text(
//               //         'Picture-in-picture',
//               //         style: TextStyle(
//               //           fontFamily: fontFamily,
//               //           fontSize: 14.sp,
//               //           color: Colors.white60
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               SizedBox(height: 10.h,)
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }















// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/colors.dart';
// import '../../../config/constants.dart';
//
// class CustomPlansContainer extends StatefulWidget {
//   final String planName;
//   final String planPrice;
//   final String timePeriod;
//   final bool isPlanSelected;
//   final List<String> feature;
//   final VoidCallback onTap;
//
//   const CustomPlansContainer({
//     super.key,
//     required this.planName,
//     required this.planPrice,
//     required this.timePeriod,
//     required this.isPlanSelected,
//     required this.feature,
//     required this.onTap,
//   });
//
//   @override
//   _CustomPlansContainerState createState() => _CustomPlansContainerState();
// }
//
// class _CustomPlansContainerState extends State<CustomPlansContainer> {
//   bool _isExpanded = false;
//
//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: widget.onTap,
//       child: Container(
//         // duration: Duration(milliseconds: 300),
//         padding: EdgeInsets.symmetric(horizontal: 15.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: widget.isPlanSelected
//               ? Border.all(
//             width: 3.5,
//             color: primaryColor,
//           )
//               : Border.all(
//             width: 1.0,
//             color: greyShade400,
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: _isExpanded ? 70.h : 80.h, // Adjust height based on expansion
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         widget.planName,
//                         style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700,
//                           // color: Colors.white,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             widget.planPrice,
//                             style: TextStyle(
//                               fontFamily: fontFamily,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w300,
//                               // color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(width: 5.w),
//                           Text(
//                             '/${widget.timePeriod}',
//                             style: TextStyle(
//                               fontFamily: fontFamily,
//                               color: Colors.white60,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(height: 8.h),
//                       Container(
//                         height: 14.h,
//                         width: 16.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           border: widget.isPlanSelected
//                               ? Border.all(
//                             width: 5.5,
//                             color: primaryColor,
//                           )
//                               : Border.all(
//                             width: 1.2,
//                             color: greyShade500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             TextButton(
//               onPressed: _toggleExpand,
//               child: Text(
//                 _isExpanded ? 'Hide benefits' : 'Show benefits',
//                 style: TextStyle(
//                   color: greyShade500,
//                 ),
//               ),
//             ),
//             if (_isExpanded) ...[
//               SizedBox(height: 10.h),
//               Row(
//                 children: [
//                   Text(
//                     'Features:',
//                     style: TextStyle(
//                       fontFamily: fontFamily,
//                       fontSize: 14.sp,
//                       // color: Colors.white60,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.h),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.feature.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.check, color: Colors.green, size: 16.0),
//                         SizedBox(width: 8.0),
//                         Text(
//                           widget.feature[index],
//                           style: TextStyle(
//                             fontFamily: fontFamily,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white60,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 10.h),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }














import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../../config/colors.dart';
import '../../../config/constants.dart';

class CustomPlansContainer extends StatefulWidget {
  final String planName;
  final String planPrice;
  final String timePeriod;
  final bool isPlanSelected;
  final List<String> feature;
  final VoidCallback onTap;
  final bool? isActive;
  final String? activePlanName;

  const CustomPlansContainer({
    super.key,
    required this.planName,
    required this.planPrice,
    required this.timePeriod,
    required this.isPlanSelected,
    required this.feature,
    required this.onTap,
    this.isActive,
    this.activePlanName
  });

  @override
  _CustomPlansContainerState createState() => _CustomPlansContainerState();
}

class _CustomPlansContainerState extends State<CustomPlansContainer> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: widget.onTap,
      child: Stack(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: widget.isActive == true
                    ? Border.all(
                  width: 1.0,
                  color: primaryColor,
                )
                    : Border.all(
                  width: 1.0,
                  color: greyShade400,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: _isExpanded ? 70.h : 70.h, // Adjust height based on expansion
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.planName,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 14.sp,
                                // fontWeight: FontWeight.w700,
                                // color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.planPrice,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    // color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '/${widget.timePeriod}',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: 10.h
                        //   ),
                        //   child: Container(
                        //     height: 14.h,
                        //     width: 16.w,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(100),
                        //       border: widget.isPlanSelected ? Border.all(
                        //         width: 5.5,
                        //         color: primaryColor,
                        //       ) : Border.all(
                        //         width: 1.5,
                        //         color: greyShade500,
                        //       ),
                        //     ),
                        //
                        //     // child: Text(
                        //     //     'Activated',
                        //     //   style: TextStyle(
                        //     //     fontFamily: fontFamily,
                        //     //     fontSize: 12.sp
                        //     //   ),
                        //     // ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    // borderRadius: BorderRadius.circular(25),
                    onTap: _toggleExpand,
                    child: Container(
                      alignment: Alignment.center,
                      width: _isExpanded ? 103.w : 108.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _isExpanded ? 'Hide benefits' : 'Show benefits',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondaryFixedDim
                              // color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 3.w,),
                          _isExpanded
                              ? Icon(HeroiconsOutline.chevronUp, size: 13.r, color: Theme.of(context).colorScheme.secondaryFixedDim,)
                              : Icon(HeroiconsOutline.chevronDown, size: 13.r, color: Theme.of(context).colorScheme.secondaryFixedDim,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  if (_isExpanded) ...[
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          'Features:',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 14.sp,
                            // color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.feature.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check, color: Colors.green, size: 16.0),
                              SizedBox(width: 8.0),
                              Text(
                                widget.feature[index],
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 14.sp,
                                  // fontWeight: FontWeight.w200,
                                  // color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ],
              ),
            ),
          ),
          widget.isActive == true ? Positioned(
            top: 0,
            right: 0,
              child: Container(
                height: 22.h,
                width: 65.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)
                  ),
                  color: primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                    'Activated',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.sp,
                    color: Colors.white
                  ),
                ),
              )
          ) : SizedBox.shrink(),

          widget.activePlanName == "No active plan" ? Positioned(
            top: 8.h,
            right: 12.w,
            child: Container(
              height: 14.h,
              width: 16.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: widget.isPlanSelected ? Border.all(
                  width: 5.5,
                  color: primaryColor,
                ) : Border.all(
                  width: 1.5,
                  color: greyShade500,
                ),
              ),

              // child: Text(
              //     'Activated',
              //   style: TextStyle(
              //     fontFamily: fontFamily,
              //     fontSize: 12.sp
              //   ),
              // ),
            ),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}
