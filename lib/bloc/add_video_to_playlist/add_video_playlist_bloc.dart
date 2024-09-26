import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/add_video_playlist_repo.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_event.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_state.dart';

class AddVideoToPlaylistBloc extends Bloc<AddVideoToPlaylistEvent, AddVideoToPlaylistState>{
  AddVideoToPlaylistBloc() : super(AddVideoToPlaylistInitial()){
    on<AddVideoToPlaylistRequest>(_onAddVideoToPlaylistRequest);
    on<InitializePlaylistBloc>(_onInitializePlaylistBloc);
  }

  Future<void> _onAddVideoToPlaylistRequest(AddVideoToPlaylistRequest event, Emitter<AddVideoToPlaylistState> emit) async {
    try{
      final String message = await AddVideoToPlaylistRepo().addVideoToPlaylist(event.playlistIds, event.videoId);
      print('Video Successfully Added to Playlist');
      emit(AddVideoToPlaylistSuccess(message: message));
    }catch(e){
      emit(AddVideoToPlaylistFailure(error: e.toString()));
    }
  }

  Future<void> _onInitializePlaylistBloc(InitializePlaylistBloc event, Emitter<AddVideoToPlaylistState> emit) async {
    emit(AddVideoToPlaylistInitial());
  }

}