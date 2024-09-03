import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_bloc.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_event.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_state.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_bloc.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_state.dart';
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
  final userNumber = Global.userData!.userNumber;
  final userEmail = Global.userData!.userEmail;
  bool isPlanSelected = false;
  late double selectedPrice = 0.0;
  late int selectedPlanId = -1;
  var planName = '';





  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> buyPlan(
      String userName,
      String key,
      String orderId,
      double amount,
      String planName,
      String userNumber,
      String userEmail) async {
    String amountInPaise = (amount * 100).toString();

    var options = {
      'key': 'rzp_test_43YUyaXUhNqIVZ',
      'amount': amountInPaise,
      'name': userName,
      'description': planName,
      'order_id': orderId,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': userNumber, 'email': userEmail},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error opening Razorpay: $e');
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    print('External Wallet Selected: ${response.walletName}');
  }








  // Future<dynamic> buyPlan(
  //     String userName,
  //     String key,
  //     double amount,
  //
  //     ) async {
  //   Razorpay razorpay = Razorpay();
  //   var options = {
  //     'key': key,
  //     'amount': amount,
  //     'name': userName,
  //     'description': 'Fine T-Shirt',
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  //   razorpay.open(options);
  // }
  //
  // void handlePaymentErrorResponse(PaymentFailureResponse response){
  //   /*
  //   * PaymentFailureResponse contains three values:
  //   * 1. Error Code
  //   * 2. Error Description
  //   * 3. Metadata
  //   * */
  //   showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  // }
  //
  // void handlePaymentSuccessResponse(PaymentSuccessResponse response){
  //   /*
  //   * Payment Success Response contains three values:
  //   * 1. Order ID
  //   * 2. Payment ID
  //   * 3. Signature
  //   * */
  //   showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  // }
  //
  // void handleExternalWalletSelected(ExternalWalletResponse response){
  //   showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  // }
  //
  // void showAlertDialog(BuildContext context, String title, String message){
  //   // set up the buttons
  //   Widget continueButton = ElevatedButton(
  //     child: const Text("Continue"),
  //     onPressed:  () {},
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              GoRouter.of(context).pop();
            },
            icon: Icon(HeroiconsOutline.xMark, )
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 userHeaderWidget(),
                 SizedBox(height: 25.h,),
                 Text(
                     'Choose a plan',
                     style: const TextStyle(
                         fontFamily: fontFamily,
                         fontSize: 20,
                       // color: Colors.white
                     )
                 ),
                 Text(
                     'Monthly or yearly? it\'s your call',
                     style: TextStyle(
                         fontFamily: fontFamily,
                         fontSize: 13,
                       color: Theme.of(context).colorScheme.onTertiaryFixedVariant
                     )
                 ),
                 SizedBox(height: 10.h,),
                 plansList(),
               ],
            ),
          ),
        ),
      ),


      // bottomNavigationBar: _selectedPlanIndex >= 0
      //     ? BottomAppBar(
      //   child: BlocBuilder<GenerateSignatureBloc, GenerateSignatureState>(
      //     builder: (BuildContext context, GenerateSignatureState state) {
      //       var key = '';
      //       var orderId = '';
      //       if (state is GenerateSignatureSuccess) {
      //         key = state.signatureData.isNotEmpty ? state.signatureData[0].keyId ?? '' : '';
      //         orderId = state.signatureData.isNotEmpty ? state.signatureData[0].orderId ?? '' : '';
      //         print('Key: $key');
      //         print('Order ID: $orderId');
      //       }
      //
      //       return ElevatedButton(
      //         onPressed: () {
      //           // Ensure `GenerateSignatureBloc` request is made to update the state
      //           context.read<GenerateSignatureBloc>().add(GenerateSignatureRequest(planId: selectedPlanId));
      //
      //           // Print values for debugging
      //           print('Selected Price: $selectedPrice');
      //           print('User Name: $userName');
      //           print('Key: $key');
      //           print('Order ID: $orderId');
      //
      //           // Call buyPlan with correct parameters if data is valid
      //           if (userName != null && key.isNotEmpty && orderId.isNotEmpty && selectedPrice > 0) {
      //             buyPlan(
      //               userName!,
      //               key,
      //               orderId,
      //               selectedPrice,
      //             );
      //           } else {
      //             print('Error: Invalid parameters');
      //           }
      //         },
      //         style: ElevatedButton.styleFrom(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //         ),
      //         child: Text(
      //           'Pay Rs $selectedPrice',
      //           style: TextStyle(
      //             fontFamily: fontFamily,
      //             fontSize: 18,
      //             color: Colors.white,
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // )
      //     : null,




      bottomNavigationBar: _selectedPlanIndex >= 0 ? BottomAppBar(
        child: BlocBuilder<GenerateSignatureBloc, GenerateSignatureState>(
          builder: (BuildContext context, GenerateSignatureState state) {
            print('fgnbrghghsrugsug      $state');
            var key = '';
            var orderId = '';

            if(state is GenerateSignatureSuccess){
              print('dlonmhjdonhiodtehbniojtioJTbhnmib');
              key = state.signatureData[0].keyId!;
              orderId = state.signatureData.first.orderId!;
              print('TTTTTTTTTTTTTTTT     ${state.signatureData.first.orderId}');
            }

            return ElevatedButton(
                onPressed: (){
                  print(';;;;;;;;;;    $selectedPrice');
                  context.read<GenerateSignatureBloc>().add(GenerateSignatureRequest(planId: selectedPlanId));

                  print('vvvvvvvvvvvv    $userName');
                  print('vvvvvvvvvvvv    $key');
                  print('vvvvvvvvvvvv    $orderId');
                  print('vvvvvvvvvvvv    $selectedPrice');
                   buyPlan(
                       userName!,
                       key,
                       orderId,
                       selectedPrice,
                     planName,
                     userNumber!,
                     userEmail!
                   );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Pay Rs $selectedPrice',
                  style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      color: Colors.white
                  ),
                )
            );
          },
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
              // color: Colors.white70
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
                  // color: Colors.white
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

  int _selectedPlanIndex = -1;

  Widget plansList() {
    return BlocBuilder<GetPlansBloc, GetPlansState>(
      builder: (BuildContext context, GetPlansState state) {
        if(state is GetPlansLoaded){
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.plansList.first.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final plansData = state.plansList.first.data![index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CustomPlansContainer(
                  planName: '${plansData.name}',
                  planPrice: '${plansData.price}',
                  timePeriod: '${plansData.timePeriod}',
                  feature: plansData.features!,
                  isPlanSelected: index == _selectedPlanIndex,
                  // isExpanded: index == _selectedPlanIndex,
                  // isExpanded: false,
                  onTap: () {
                    setState(() {
                      _selectedPlanIndex = index;
                      selectedPrice = double.parse(plansData.price!);
                      selectedPlanId = plansData.id!;
                      planName = plansData.name!;
                      print('nsgvnsnbgsrngjbngjnbjbninbnb   $selectedPrice');
                    });
                  },
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}


