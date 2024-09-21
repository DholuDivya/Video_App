import 'package:equatable/equatable.dart';

abstract class GetUserPlaylistEvent extends Equatable{}

class GetUserPlaylistRequest extends GetUserPlaylistEvent{
  @override
  List<Object?> get props => [];
}

class LoadMoreUserPlaylist extends GetUserPlaylistEvent{
  @override
  List<Object?> get props => [];
}