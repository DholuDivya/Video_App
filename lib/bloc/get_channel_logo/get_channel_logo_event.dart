import 'package:equatable/equatable.dart';

abstract class GetChannelLogoEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class OpenFilesToGetChannelLogo extends GetChannelLogoEvent{}