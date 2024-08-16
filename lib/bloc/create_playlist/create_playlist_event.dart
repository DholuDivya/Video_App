import 'package:equatable/equatable.dart';

abstract class CreatePlaylistEvent extends Equatable{}

class CreatePlaylistRequest extends CreatePlaylistEvent{
  final String playlistTitle;
  final String playlistDescription;
  final String playlistStatus;

  CreatePlaylistRequest({required this.playlistTitle, required this.playlistDescription, required this.playlistStatus});

  @override
  List<Object?> get props => [playlistTitle, playlistDescription, playlistStatus];
}