import 'package:equatable/equatable.dart';

abstract class ShowSinglePlaylistEvent extends Equatable{}

class ShowSinglePlaylistRequest extends ShowSinglePlaylistEvent{
  final int playlistId;

  ShowSinglePlaylistRequest({required this.playlistId});

  @override
  List<Object?> get props => [playlistId];
}