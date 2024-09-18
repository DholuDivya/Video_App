import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/app_privacy_content_model.dart';

abstract class AboutUsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AboutUsInitial extends AboutUsState{}

class AboutUsLoading extends AboutUsState{}

class AboutUsSuccess extends AboutUsState{
  final List<AppPrivacyContentModel> aboutUsLink;

  AboutUsSuccess({required this.aboutUsLink});

  @override
  List<Object?> get props => [aboutUsLink];
}

class AboutUsFailure extends AboutUsState{
  final String error;

  AboutUsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}