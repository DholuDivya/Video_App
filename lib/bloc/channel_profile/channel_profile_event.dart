import 'package:equatable/equatable.dart';

abstract class ChannelProfileEvent extends Equatable{}

class GetChannelProfileEvent extends ChannelProfileEvent{
  final String channelId;

  GetChannelProfileEvent({required this.channelId});

  @override
  List<Object?> get props => [];
}