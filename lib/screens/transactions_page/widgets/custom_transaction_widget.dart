import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import '../../../utils/widgets/dash_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomTransactionWidget extends StatelessWidget {
  final String userName;
  final String transactionStatus;
  final String amount;
  final String createdAt;
  final int transactionId;
  final String timePeriod;
  final String planName;
  final String currency;

  const CustomTransactionWidget({
    super.key,
    required this.userName,
    required this.transactionStatus,
    required this.amount,
    required this.createdAt,
    required this.transactionId,
    required this.timePeriod,
    required this.planName,
    required this.currency
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        // Handle tap if needed
      },
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Header (Name, Date, Status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // User Information
                Row(
                  children: [
                    // Profile Picture
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(
                          '${Global.userData!.userProfilePhoto}'),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          userName,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        // Transaction Status & Date
                        Row(
                          children: [
                            if(transactionStatus == AppLocalizations.of(context)!.success) Icon(Remix.circle_fill, size: 10.r, color: green),
                            if(transactionStatus == AppLocalizations.of(context)!.failed) Icon(Remix.circle_fill, size: 10.r, color: red),
                            if(transactionStatus == AppLocalizations.of(context)!.pending) Icon(Remix.circle_fill, size: 10.r, color: yellow),
                            SizedBox(width: 5.w),
                            Container(
                              width: 120.w,
                              child: Text(
                                '$transactionStatus - $createdAt',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.primaryFixedDim,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Transaction Amount
                Container(
                  height: 25.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(transactionStatus == AppLocalizations.of(context)!.success)Text(
                        "$currency $amount",
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      if(transactionStatus == AppLocalizations.of(context)!.failed)Text(
                        "$currency $amount",
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      if(transactionStatus == AppLocalizations.of(context)!.pending)Text(
                        "$currency $amount",
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: greyShade400,
                        ),
                      ),
                      // SizedBox(height: 15.h),
                      // Text(
                      //   'Credit',
                      //   style: TextStyle(
                      //     fontFamily: fontFamily,
                      //     fontSize: 12.sp,
                      //     fontWeight: FontWeight.w500,
                      //     color: green,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(color: Colors.grey.shade300, height: 25.h),

            // Transaction Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Transaction ID
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.transactionId,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      transactionId.toString(),
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),

                // Payment Method
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.paymentMethod,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'RazorPay',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            DashDivider(color: greyShade400,),
            SizedBox(height: 10.h,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.plan,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    Text(
                      planName,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.timePeriod,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      timePeriod,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
