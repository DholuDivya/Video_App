import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

abstract class PlaylistSelectionEvent extends Equatable{}

class SelectPlaylistRequest extends PlaylistSelectionEvent{
  final int playlistId;

  SelectPlaylistRequest({required this.playlistId});

  @override
  List<Object?> get props => [playlistId];
}

class DeselectPlaylistRequest extends PlaylistSelectionEvent{
  final int playlistId;

  DeselectPlaylistRequest({required this.playlistId});

  @override
  List<Object?> get props => [playlistId];
}