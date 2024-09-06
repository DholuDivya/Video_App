import 'package:equatable/equatable.dart';

abstract class RemoveVideoFromPlaylistEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class RemoveVideoFromPlaylistRequest extends RemoveVideoFromPlaylistEvent{
  final List<int> videoIds;
  final int playlistId;

  RemoveVideoFromPlaylistRequest({required this.videoIds, required this.playlistId});

  @override
  List<Object?> get props => [videoIds, playlistId];
}