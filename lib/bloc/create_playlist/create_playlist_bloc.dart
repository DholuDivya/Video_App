import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/create_playlist_repo.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_event.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_state.dart';

class CreatePlaylistBloc extends Bloc<CreatePlaylistEvent, CreatePlaylistState>{
  CreatePlaylistBloc() : super(CreatePlaylistInitial()){
    on<CreatePlaylistRequest>(_onCreatePlaylistRequest);
  }

  Future<void> _onCreatePlaylistRequest(CreatePlaylistRequest event, Emitter<CreatePlaylistState> emit) async {
    try{
      await CreatePlaylistRepo().createPlaylist(
          event.playlistTitle,
          event.playlistDescription,
          event.playlistStatus
      );
      emit(CreatePlaylistSuccess());
    }catch(e){
      emit(CreatePlaylistFailure(error: e.toString()));
    }
  }

}