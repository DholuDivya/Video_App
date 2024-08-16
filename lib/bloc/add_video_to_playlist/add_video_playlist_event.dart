import 'package:equatable/equatable.dart';

abstract class AddVideoToPlaylistEvent extends Equatable{}

class AddVideoToPlaylistRequest extends AddVideoToPlaylistEvent{
  final int playlistId;
  final int videoId;

  AddVideoToPlaylistRequest({required this.videoId, required this.playlistId});

  @override
  List<Object?> get props => [playlistId ,videoId];
}