import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/verify_payment_model.dart';

abstract class VerifyPaymentState extends Equatable{
  @override
  List<Object?> get props => [];
}

class VerifyPaymentInitial extends VerifyPaymentState{}

class VerifyPaymentLoading extends VerifyPaymentState{}

class VerifyPaymentLoaded extends VerifyPaymentState{
  final List<VerifyPaymentModel> verifyUserPayment;

  VerifyPaymentLoaded({required this.verifyUserPayment});

  @override
  List<Object?> get props => [];
}

class VerifyPaymentFailure extends VerifyPaymentState{
  final String error;

  VerifyPaymentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}