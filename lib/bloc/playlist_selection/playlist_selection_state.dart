import 'package:equatable/equatable.dart';

abstract class PlaylistSelectionState extends Equatable{}

class PlaylistSelectionInitial extends PlaylistSelectionState{
  @override
  List<Object?> get props => [];
}

class PlaylistSelected extends PlaylistSelectionState{
  final List<int> selectedPlaylistIds;

  PlaylistSelected({required this.selectedPlaylistIds});

  @override
  List<Object?> get props => [selectedPlaylistIds];
}
