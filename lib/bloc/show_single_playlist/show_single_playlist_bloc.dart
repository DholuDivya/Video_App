import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/show_single_playlist_repo.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_event.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_state.dart';
import 'package:vimeo_clone/model/show_single_playlist_model.dart';

class ShowSinglePlaylistBloc
    extends Bloc<ShowSinglePlaylistEvent, ShowSinglePlaylistState> {
  ShowSinglePlaylistBloc() : super(ShowSinglePlaylistInitial()) {
    on<ShowSinglePlaylistRequest>(_onShowSinglePlaylistRequest);
  }

  Future<void> _onShowSinglePlaylistRequest(ShowSinglePlaylistRequest event,
      Emitter<ShowSinglePlaylistState> emit) async {
    try {
      final List<ShowSinglePlaylistModel>? singlePlaylistData =
          await ShowSinglePlaylistRepo().showSinglePlaylist(event.playlistId);

      emit(ShowSinglePlaylistLoaded(singlePlaylistData: singlePlaylistData!));
    } catch (e) {
      emit(ShowSinglePlaylistFailure(error: e.toString()));
    }
  }
}
