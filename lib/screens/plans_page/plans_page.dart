import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/plans_page/widgets/custom_plans_container.dart';

import '../../config/global_variable.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final userName = Global.userData!.userName;
  final userProfile = Global.userData!.userProfilePhoto;
  bool isPlanSelected = false;
  late String selectedPrice = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: primaryColor,
      backgroundColor: Color(0xFF090c70),
      appBar: AppBar(
        backgroundColor: Color(0xFF090c70),
        leading: IconButton(
            onPressed: (){
              GoRouter.of(context).pop();
            },
            icon: Icon(HeroiconsOutline.xMark, color: Colors.white,)
        ),
        // leading: Container(),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         GoRouter.of(context).pop();
        //       },
        //       icon: Icon(HeroiconsOutline.xMark, color: Colors.white,)
        //   ),
        //   SizedBox(width: 5.w,)
        // ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w
              ),
              child: Column(
                children: [
                  Text(
                    'Unlock Unlimited Access',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: Colors.white,
                      fontSize: 18.sp
                    ),
                  ),
                  SizedBox(height: 22.h,),
                  customFeaturePreview('Ads free'),
                  SizedBox(height: 8.h,),
                  customFeaturePreview('Access premium content'),
                  SizedBox(height: 8.h,),
                  customFeaturePreview('Picture-in-picture'),
                  SizedBox(height: 70.h,),

                  plansList(),

                ],
              ),
            ),
          )
      ),














      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: EdgeInsets.only(
      //         left: 15.w,
      //         right: 15.w
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //          children: [
      //            // Row(
      //            //   mainAxisAlignment: MainAxisAlignment.end,
      //            //   children: [
      //            //     IconButton(
      //            //         onPressed: (){
      //            //           GoRouter.of(context).pop();
      //            //           // Navigator.pop(context);
      //            //         },
      //            //         icon: Icon(HeroiconsOutline.xMark)
      //            //     )
      //            //   ],
      //            // ),
      //
      //
      //            userHeaderWidget(),
      //            SizedBox(height: 25.h,),
      //            Text(
      //                'Choose a plan',
      //                style: const TextStyle(
      //                    fontFamily: fontFamily,
      //                    fontSize: 20,
      //                  color: Colors.white
      //                )
      //            ),
      //            Text(
      //                'Monthly or yearly? it\'s your call',
      //                style: TextStyle(
      //                    fontFamily: fontFamily,
      //                    fontSize: 13,
      //                  color: Theme.of(context).colorScheme.onTertiaryFixedVariant
      //                )
      //            ),
      //            SizedBox(height: 10.h,),
      //
      //
      //            plansList(),
      //
      //
      //          ],
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: _selectedPlanIndex >= 0 ? BottomAppBar(
        color: Color(0xFF090c70),
        child: ElevatedButton(
            onPressed: (){
              print(';;;;;;;;;;    $selectedPrice');
            },
            style: ElevatedButton.styleFrom(
              // padding: EdgeInsets.symmetric(
              //     horizontal: 150.w, vertical: 10.h),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Pay Rs $selectedPrice',
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                color: Colors.black
              ),
            )
        ),
      ) : null,
    );
  }


  Widget customFeaturePreview(String featureName){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.check, color: Colors.green, size: 16.0.r),
        SizedBox(width: 8.0),
        Text(
          featureName,
          style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16.sp,
              color: Colors.white70
          ),
        ),
      ],
    );
  }
  
  
  

  Widget userHeaderWidget(){
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundImage: NetworkImage(userProfile!),
          // backgroundColor: blue,
        ),

        SizedBox(width: 8.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                userName!,
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 17.sp,
                  color: Colors.white
                )
            ),

            Text(
                'Full access subscription ',
                style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: fontFamily,
                    color: Theme.of(context).colorScheme.onTertiaryFixedVariant
                )
            ),
          ],
        )
      ],
    );
  }


  List<Map<String, dynamic>> plans = [
    {
      'planName': 'Basic Plan',
      'planPrice': '9.99',
      'planTimePeriod': '1 month'
    },
    {
      'planName': 'Standard Plan',
      'planPrice': '24.99',
      'planTimePeriod': '3 months'
    },
    {
      'planName': 'Pro Plan',
      'planPrice': '59.99',
      'planTimePeriod': '6 months'
    },
    {
      'planName': 'Premium Plan',
      'planPrice': '99.99',
      'planTimePeriod': '12 months'
    },
    {
      'planName': 'Lifetime Plan',
      'planPrice': '199.99',
      'planTimePeriod': 'lifetime'
    },
  ];
  int _selectedPlanIndex = -1;


  Widget plansList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: plans.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CustomPlansContainer(
            planName: '${plans[index]['planName']}',
            planPrice: 'Rs ${plans[index]['planPrice']}',
            timePeriod: '${plans[index]['planTimePeriod']}',
            isPlanSelected: index == _selectedPlanIndex,
            isExpanded: false,
            onTap: () {
              setState(() {
                _selectedPlanIndex = index;
                selectedPrice = plans[index]['planPrice'];
                print('nsgvnsnbgsrngjbngjnbjbninbnb   $selectedPrice');
              });
            },
          ),
        );
      },
    );
  }

}


