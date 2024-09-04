import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/verify_payment_repo.dart';
import 'package:vimeo_clone/bloc/verify_payment/verify_payment_event.dart';
import 'package:vimeo_clone/bloc/verify_payment/verify_payment_state.dart';
import 'package:vimeo_clone/model/verify_payment_model.dart';

class VerifyPaymentBloc extends Bloc<VerifyPaymentEvent, VerifyPaymentState>{
  VerifyPaymentBloc() : super(VerifyPaymentInitial()){
    on<VerifyPaymentRequest>(_onVerifyPaymentRequest);
  }

  Future<void> _onVerifyPaymentRequest(VerifyPaymentRequest event, Emitter<VerifyPaymentState> emit) async {
    try{
      final List<VerifyPaymentModel>? verifyUserPayment = await VerifyPaymentRepo().verifyPayment(
        event.razorpayOrderId, event.razorpayPaymentId, event.razorpaySignature, event.planId
      );
      print('llllllllllllll        ${verifyUserPayment!.first.message}');
      emit(VerifyPaymentLoaded(verifyUserPayment: verifyUserPayment));
    }catch(e){
      emit(VerifyPaymentFailure(error: e.toString()));
    }
  }
}