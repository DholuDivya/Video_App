import 'package:equatable/equatable.dart';

abstract class YourShortsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class YourShortsRequest extends YourShortsEvent{
  final int channelId;

  YourShortsRequest({required this.channelId});

  @override
  List<Object?> get props => [channelId];
}

class LoadMoreYourShorts extends YourShortsEvent{}