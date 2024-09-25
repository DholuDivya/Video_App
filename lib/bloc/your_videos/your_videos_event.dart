import 'package:equatable/equatable.dart';

abstract class YourVideosEvent extends Equatable{}

class GetYourVideosEvent extends YourVideosEvent{
  final int channelId;

  GetYourVideosEvent({required this.channelId});

  @override
  List<Object?> get props => [];
}

class LoadMoreYourVideos extends YourVideosEvent{
  @override
  List<Object?> get props => [];
}