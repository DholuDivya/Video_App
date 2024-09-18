import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/app_privacy_content_model.dart';

abstract class TermsAndConditionsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TermsAndConditionsInitial extends TermsAndConditionsState{}

class TermsAndConditionsLoading extends TermsAndConditionsState{}

class TermsAndConditionsSuccess extends TermsAndConditionsState{
  final List<AppPrivacyContentModel> termsAndConditionLink;

  TermsAndConditionsSuccess({required this.termsAndConditionLink});

  @override
  List<Object?> get props => [termsAndConditionLink];
}

class TermsAndConditionsFailure extends TermsAndConditionsState{
  final String error;

  TermsAndConditionsFailure({required this.error});

  @override
  List<Object?> get props => [];
}