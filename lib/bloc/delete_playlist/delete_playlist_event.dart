import 'package:equatable/equatable.dart';

abstract class DeletePlaylistEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DeletePlaylistRequest extends DeletePlaylistEvent{
  final int playlistId;

  DeletePlaylistRequest({required this.playlistId});

  @override
  List<Object?> get props => [];
}