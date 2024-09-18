import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/app_privacy_content_model.dart';

abstract class PrivacyPolicyState extends Equatable{
  @override
  List<Object?> get props => [];
}

class PrivacyPolicyInitial extends PrivacyPolicyState{}

class PrivacyPolicyLoading extends PrivacyPolicyState{}

class PrivacyPolicySuccess extends PrivacyPolicyState{
  final List<AppPrivacyContentModel> privacyPolicyLink;

  PrivacyPolicySuccess({required this.privacyPolicyLink});

  @override
  List<Object?> get props => [privacyPolicyLink];
}

class PrivacyPolicyFailure extends PrivacyPolicyState{
  final String error;

  PrivacyPolicyFailure({required this.error});

  @override
  List<Object?> get props => [error];
}