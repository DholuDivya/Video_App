import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_state.dart';

class PlaylistSelectionBloc extends Bloc<PlaylistSelectionEvent, PlaylistSelectionState>{
  PlaylistSelectionBloc() : super(PlaylistSelectionInitial()){
    on<SelectPlaylistRequest>(_onSelectPlaylistRequest);
    on<DeselectPlaylistRequest>(_onDeselectPlaylistRequest);
  }

  Future<void> _onSelectPlaylistRequest(SelectPlaylistRequest event, Emitter<PlaylistSelectionState> emit) async {

    final currentSelectPlaylistIds = state is PlaylistSelected
      ? (state as PlaylistSelected).selectedPlaylistIds
      : [];
    final newSelectedPlaylistIds = List<int>.from(currentSelectPlaylistIds)..add(event.playlistId);
    print(' Selected   ----------------     $newSelectedPlaylistIds');
    emit(PlaylistSelected(selectedPlaylistIds: newSelectedPlaylistIds));

  }

  Future<void> _onDeselectPlaylistRequest(DeselectPlaylistRequest event, Emitter<PlaylistSelectionState> emit) async {
    final currentSelectPlaylistIds = state is PlaylistSelected
        ? (state as PlaylistSelected).selectedPlaylistIds
        : [];
    final newSelectedPlaylistIds = List<int>.from(currentSelectPlaylistIds)..remove(event.playlistId);
    print('  Deselected   ----------------     $newSelectedPlaylistIds');
    emit(PlaylistSelected(selectedPlaylistIds: newSelectedPlaylistIds));
  }

}