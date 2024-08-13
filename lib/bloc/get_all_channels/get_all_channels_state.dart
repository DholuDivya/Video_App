import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_all_channels_model.dart';

abstract class GetAllChannelsState extends Equatable{}

class GetAllChannelsInitial extends GetAllChannelsState{
  @override
  List<Object?> get props => [];
}

class GetAllChannelsLoading extends GetAllChannelsState{
  @override
  List<Object?> get props => [];
}

class GetAllChannelsLoaded extends GetAllChannelsState{
  final List<GetAllChannelsModel> channelList;

  GetAllChannelsLoaded({required this.channelList});

  @override
  List<Object?> get props => [channelList];
}

class GetAllChannelsFailure extends GetAllChannelsState{
  final String error;

  GetAllChannelsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}