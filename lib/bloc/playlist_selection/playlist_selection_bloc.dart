import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_state.dart';

// class PlaylistSelectionBloc extends Bloc<PlaylistSelectionEvent, PlaylistSelectionState>{
//   PlaylistSelectionBloc() : super(PlaylistSelectionInitial()){
//     on<SelectPlaylistRequest>(_onSelectPlaylistRequest);
//     on<DeselectPlaylistRequest>(_onDeselectPlaylistRequest);
//   }
//
//   Future<void> _onSelectPlaylistRequest(SelectPlaylistRequest event, Emitter<PlaylistSelectionState> emit) async {
//
//     final currentSelectPlaylistIds = state is PlaylistSelected
//       ? (state as PlaylistSelected).selectedPlaylistIds
//       : [];
//     final newSelectedPlaylistIds = List<int>.from(currentSelectPlaylistIds)..add(event.playlistId);
//     print(' Selected   ----------------     $newSelectedPlaylistIds');
//     emit(PlaylistSelected(selectedPlaylistIds: newSelectedPlaylistIds));
//
//   }
//
//   Future<void> _onDeselectPlaylistRequest(DeselectPlaylistRequest event, Emitter<PlaylistSelectionState> emit) async {
//     final currentSelectPlaylistIds = state is PlaylistSelected
//         ? (state as PlaylistSelected).selectedPlaylistIds
//         : [];
//     final newSelectedPlaylistIds = List<int>.from(currentSelectPlaylistIds)..remove(event.playlistId);
//     print('  Deselected   ----------------     $newSelectedPlaylistIds');
//     emit(PlaylistSelected(selectedPlaylistIds: newSelectedPlaylistIds));
//   }
//
// }


class PlaylistSelectionBloc extends Bloc<PlaylistSelectionEvent, PlaylistSelectionState> {
  PlaylistSelectionBloc() : super(PlaylistSelectionInitial()) {
    on<SelectPlaylistRequest>(_onSelectPlaylistRequest);
    on<DeselectPlaylistRequest>(_onDeselectPlaylistRequest);
    on<ClearPlaylistSelectionRequest>(_onClearPlaylistSelectionRequest); // New handler for clearing the selection
  }

  // Handler for selecting a playlist
  Future<void> _onSelectPlaylistRequest(SelectPlaylistRequest event, Emitter<PlaylistSelectionState> emit) async {
    final currentSelectPlaylistIds = state is PlaylistSelected
        ? (state as PlaylistSelected).selectedPlaylistIds
        : [];

    if (!currentSelectPlaylistIds.contains(event.playlistId)) {
      final newSelectedPlaylistIds = List<int>.from(currentSelectPlaylistIds)..add(event.playlistId);
      print('Selected Playlists: $newSelectedPlaylistIds');
      emit(PlaylistSelected(selectedPlaylistIds: newSelectedPlaylistIds));
    }
  }

  // Handler for deselecting a playlist
  Future<void> _onDeselectPlaylistRequest(DeselectPlaylistRequest event, Emitter<PlaylistSelectionState> emit) async {
    final currentSelectPlaylistIds = state is PlaylistSelected
        ? (state as PlaylistSelected).selectedPlaylistIds
        : [];

    if (currentSelectPlaylistIds.contains(event.playlistId)) {
      final newSelectedPlaylistIds = List<int>.from(currentSelectPlaylistIds)..remove(event.playlistId);
      print('Deselected Playlists: $newSelectedPlaylistIds');
      emit(PlaylistSelected(selectedPlaylistIds: newSelectedPlaylistIds));
    }
  }

  // New handler for clearing the selection
  Future<void> _onClearPlaylistSelectionRequest(ClearPlaylistSelectionRequest event, Emitter<PlaylistSelectionState> emit) async {
    emit(PlaylistSelectionInitial()); // Reset to the initial state, clearing any selections
    print('Cleared all selected playlists.');
  }
}
