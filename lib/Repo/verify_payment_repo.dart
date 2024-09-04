import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/verify_payment_model.dart';

class VerifyPaymentRepo{
  Future<List<VerifyPaymentModel>?> verifyPayment(
      String razorpayOrderId,
      String razorpayPaymentId,
      String razorpaySignature,
      int planId,
      ) async {
    try{
      final response = await ApiBaseHelper().postAPICall(verifyPaymentUrl, {
        "razorpay_order_id": razorpayOrderId,
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_signature": razorpaySignature,
        "plan_id": planId
      });

      if(response.statusCode == 200){
        List<VerifyPaymentModel> verifyUserPayment = [];
        verifyUserPayment.add(VerifyPaymentModel.fromJson(response.data));
        print('Payment is verified successfully');
        return verifyUserPayment;
      }
    }catch(e){
      throw ApiException('Fail to call verify payment API');
    }
    return null;
  }
}