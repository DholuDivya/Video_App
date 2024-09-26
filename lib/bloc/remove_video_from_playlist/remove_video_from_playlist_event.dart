import 'package:equatable/equatable.dart';

abstract class RemoveVideoFromPlaylistEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class RemoveVideoFromPlaylistRequest extends RemoveVideoFromPlaylistEvent{
  final int videoId;
  final int playlistId;

  RemoveVideoFromPlaylistRequest({required this.videoId, required this.playlistId});

  @override
  List<Object?> get props => [videoId, playlistId];
}