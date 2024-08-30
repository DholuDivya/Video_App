import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class GetChannelLogoState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetChannelLogoInitial extends GetChannelLogoState{}

class GetChannelLogoLoading extends GetChannelLogoState{}

class GetChannelLogoLoaded extends GetChannelLogoState{
  final CroppedFile? channelLogo;

  GetChannelLogoLoaded({this.channelLogo});

  @override
  List<Object?> get props => [channelLogo];
}

class GetChannelLogoFailure extends GetChannelLogoState{
  final String error;

  GetChannelLogoFailure({required this.error});

  @override
  List<Object?> get props => [];
}
