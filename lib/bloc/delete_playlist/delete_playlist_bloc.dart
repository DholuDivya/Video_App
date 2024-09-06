import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/delete_playlist_repo.dart';
import 'package:vimeo_clone/bloc/delete_playlist/delete_playlist_event.dart';
import 'package:vimeo_clone/bloc/delete_playlist/delete_playlist_state.dart';

class DeletePlaylistBloc extends Bloc<DeletePlaylistEvent, DeletePlaylistState>{
  DeletePlaylistBloc() : super(DeletePlaylistInitial()){
    on<DeletePlaylistRequest>(_onDeletePlaylistRequest);
  }

  Future<void> _onDeletePlaylistRequest(DeletePlaylistRequest event, Emitter<DeletePlaylistState> emit) async {
    try{
      await DeletePlaylistRepo().deletePlaylist(event.playlistId);
      emit(DeletePlaylistSuccess());
    }catch(e){
      emit(DeletePlaylistFailure(error: e.toString()));
    }
  }
}