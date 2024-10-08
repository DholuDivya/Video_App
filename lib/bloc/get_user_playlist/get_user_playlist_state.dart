import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

abstract class GetUserPlaylistState extends Equatable{}

class GetUserPlaylistInitial extends GetUserPlaylistState{
  @override
  List<Object?> get props => [];
}

class GetUserPlaylistLoading extends GetUserPlaylistState{
  @override
  List<Object?> get props => [];
}

class GetUserPlaylistSuccess extends GetUserPlaylistState{
  final List<PlaylistList> userPlaylist;
  final bool hasReachedMax;

  GetUserPlaylistSuccess({required this.userPlaylist, required this.hasReachedMax});

  @override
  List<Object?> get props => [];
}

class GetUserPlaylistFailure extends GetUserPlaylistState{
  final String error;

  GetUserPlaylistFailure({required this.error});

  @override
  List<Object?> get props => [];
}