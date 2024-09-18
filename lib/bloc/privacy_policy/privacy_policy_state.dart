import 'package:equatable/equatable.dart';

abstract class PrivacyPolicyState extends Equatable{
  @override
  List<Object?> get props => [];
}

class PrivacyPolicyInitial extends PrivacyPolicyState{}
class PrivacyPolicyLoading extends PrivacyPolicyState{}
class PrivacyPolicySuccess extends PrivacyPolicyState{}
class PrivacyPolicyFailure extends PrivacyPolicyState{
  final String error;

  PrivacyPolicyFailure({required this.error});

  @override
  List<Object?> get props => [error];
}