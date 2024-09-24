import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/show_single_playlist_model.dart';

abstract class ShowSinglePlaylistState extends Equatable{}

class ShowSinglePlaylistInitial extends ShowSinglePlaylistState{
  @override
  List<Object?> get props => [];
}

class ShowSinglePlaylistLoading extends ShowSinglePlaylistState{
  @override
  List<Object?> get props => [];
}

class ShowSinglePlaylistLoaded extends ShowSinglePlaylistState{
  final List<SinglePlaylistVideos> singlePlaylistData;
  final bool hasReachedMax;

  ShowSinglePlaylistLoaded({required this.singlePlaylistData, required this.hasReachedMax});

  @override
  List<Object?> get props => [singlePlaylistData, hasReachedMax];
}

class ShowSinglePlaylistFailure extends ShowSinglePlaylistState{
  final String error;

  ShowSinglePlaylistFailure({required this.error});

  @override
  List<Object?> get props => [error];
}