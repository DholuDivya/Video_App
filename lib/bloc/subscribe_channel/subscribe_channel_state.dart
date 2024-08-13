import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/subscribe_channel_model.dart';

abstract class SubscribeChannelState extends Equatable{}

class SubscribeChannelInitial extends SubscribeChannelState{
  @override
  List<Object?> get props => [];
}

class SubscribeChannelSuccess extends SubscribeChannelState{
  final List<SubscribeChannelModel> subscribeChannel;

  SubscribeChannelSuccess({required this.subscribeChannel});

  @override
  List<Object?> get props => [subscribeChannel];
}

class SubscribeChannelFailure extends SubscribeChannelState{
  final String error;

  SubscribeChannelFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class UnsubscribeChannelSuccess extends SubscribeChannelState{
  final List<SubscribeChannelModel> subscribeChannel;

  UnsubscribeChannelSuccess({required this.subscribeChannel});

  @override
  List<Object?> get props => [];
}

class UnsubscribeChannelFailure extends SubscribeChannelState{
  final String error;

  UnsubscribeChannelFailure({required this.error});

  @override
  List<Object?> get props => [error];
}