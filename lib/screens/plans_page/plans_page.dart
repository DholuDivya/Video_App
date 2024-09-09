import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_bloc.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_event.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_state.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_bloc.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_state.dart';
import 'package:vimeo_clone/bloc/verify_payment/verify_payment_bloc.dart';
import 'package:vimeo_clone/bloc/verify_payment/verify_payment_event.dart';
import 'package:vimeo_clone/bloc/verify_payment/verify_payment_state.dart';
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
    String userAmount = (amount * 100).toString();

    var options = {
      'key': 'rzp_test_43YUyaXUhNqIVZ',
      'amount': userAmount,
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
    print('Payment Success: ${response.orderId}');
    print('Payment Success: ${response.paymentId}');
    print('Payment Success: ${response.signature}');
    final razorpayOrderId = response.orderId;
    final razorpayPaymentId = response.paymentId;
    final razorpaySignature = response.signature;
    context.read<VerifyPaymentBloc>().add(VerifyPaymentRequest(
        razorpayOrderId: razorpayOrderId!,
        razorpayPaymentId: razorpayPaymentId!,
        razorpaySignature: razorpaySignature!,
        planId: selectedPlanId
    ));

    final verifyPaymentBloc = context.read<VerifyPaymentBloc>();
    verifyPaymentBloc.stream.listen((state){
      if(state is VerifyPaymentLoaded){
        print('yuyuyuyuyuyuyuyuuy    $state');
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Lottie.asset('assets/animation/payment_success.json', height: 80.h, width: 80.w)
                  ),
                ],
              ),
            );
          },
        );
      }else if(state is VerifyPaymentFailure){
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Lottie.asset('assets/animation/payment_failed.json',  height: 80.h, width: 80.w)
              ),
            ],
          ),
        );
      }
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    print('External Wallet Selected: ${response.walletName}');
  }






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
                 const Text(
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

      bottomNavigationBar: _selectedPlanIndex >= 0 ? BottomAppBar(
        child: BlocBuilder<GenerateSignatureBloc, GenerateSignatureState>(
          builder: (BuildContext context, GenerateSignatureState state) {
            var key = '';
            var orderId = '';
            if(state is GenerateSignatureSuccess){
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


