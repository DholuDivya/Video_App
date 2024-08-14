import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_subscribed_channel_list_model.dart';

abstract class GetSubscribedChannelListState extends Equatable{}

class GetSubscribedChannelListInitial extends GetSubscribedChannelListState{
  @override
  List<Object?> get props => [];
}

class GetSubscribedChannelListLoading extends GetSubscribedChannelListState{
  @override
  List<Object?> get props => [];
}

class GetSubscribedChannelListLoaded extends GetSubscribedChannelListState{
  final List<GetSubscribedChannelListModel> channelList;

  GetSubscribedChannelListLoaded({required this.channelList});

  @override
  List<Object?> get props => [channelList];
}

class GetSubscribedChannelListFailure extends GetSubscribedChannelListState{
  final String error;

  GetSubscribedChannelListFailure({required this.error});

  @override
  List<Object?> get props => [error];
}