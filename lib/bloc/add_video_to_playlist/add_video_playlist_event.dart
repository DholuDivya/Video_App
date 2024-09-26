import 'package:equatable/equatable.dart';

abstract class AddVideoToPlaylistEvent extends Equatable{}

class AddVideoToPlaylistRequest extends AddVideoToPlaylistEvent{
  final List<int> playlistIds;
  final int videoId;

  AddVideoToPlaylistRequest({required this.videoId, required this.playlistIds});

  @override
  List<Object?> get props => [playlistIds ,videoId];
}

class InitializePlaylistBloc extends AddVideoToPlaylistEvent{
  @override
  List<Object?> get props => [];
}