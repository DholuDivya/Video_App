import 'package:equatable/equatable.dart';

abstract class SubscribeChannelEvent extends Equatable{}

class SubscribeChannelRequest extends SubscribeChannelEvent{
  final int channelId;

  SubscribeChannelRequest({required this.channelId});

  @override
  List<Object?> get props => [channelId];
}

class UnsubscribeChannelRequest extends SubscribeChannelEvent{
  final int channelId;

  UnsubscribeChannelRequest({required this.channelId});

  @override
  List<Object?> get props => [channelId];
}