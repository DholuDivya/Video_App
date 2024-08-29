import 'package:equatable/equatable.dart';

abstract class UpdateUserEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UpdateUserRequest extends UpdateUserEvent{
  final String? channelName;
  final String? channelLogo;
  final String? channelBanner;

  UpdateUserRequest({this.channelName, this.channelLogo, this.channelBanner});

  @override
  List<Object?> get props => [channelName, channelLogo, channelBanner];
}
