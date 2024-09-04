import 'package:equatable/equatable.dart';

abstract class VerifyPaymentEvent extends Equatable{}

class VerifyPaymentRequest extends VerifyPaymentEvent{
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;
  final int planId;

  VerifyPaymentRequest({required this.razorpayOrderId,required this.razorpayPaymentId,required this.razorpaySignature,required this.planId});

  @override
  List<Object?> get props => [razorpayOrderId, razorpayPaymentId, razorpaySignature, planId];
}