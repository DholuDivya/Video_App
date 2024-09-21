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
  final List<SubscriptionsListData> channelList;
  final bool hasReachedMax;

  GetSubscribedChannelListLoaded({required this.channelList, required this.hasReachedMax});

  @override
  List<Object?> get props => [channelList, hasReachedMax];
}

class GetSubscribedChannelListFailure extends GetSubscribedChannelListState{
  final String error;

  GetSubscribedChannelListFailure({required this.error});

  @override
  List<Object?> get props => [error];
}