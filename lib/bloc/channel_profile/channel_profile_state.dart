import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';

abstract class ChannelProfileState extends Equatable{}

class ChannelProfileInitial extends ChannelProfileState{
  @override
  List<Object?> get props => [];
}

class ChannelProfileLoading extends ChannelProfileState{
  @override
  List<Object?> get props => [];
}

class ChannelProfileLoaded extends ChannelProfileState{
  final List<GetChannelDetailModel> channelData;

  ChannelProfileLoaded({required this.channelData});

  @override
  List<Object?> get props => [];
}

class ChannelProfileFailure extends ChannelProfileState{
  final String error;

  ChannelProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}