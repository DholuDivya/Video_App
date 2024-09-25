import 'package:equatable/equatable.dart';

abstract class GetUserPlaylistEvent extends Equatable{}

class GetUserPlaylistRequest extends GetUserPlaylistEvent{
  final int channelId;

  GetUserPlaylistRequest({required this.channelId});

  @override
  List<Object?> get props => [channelId];
}

class LoadMoreUserPlaylist extends GetUserPlaylistEvent{
  @override
  List<Object?> get props => [];
}