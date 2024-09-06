import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/remove_video_from_playlist_repo.dart';
import 'package:vimeo_clone/bloc/remove_video_from_playlist/remove_video_from_playlist_event.dart';
import 'package:vimeo_clone/bloc/remove_video_from_playlist/remove_video_from_playlist_state.dart';

class RemoveVideoFromPlaylistBloc extends Bloc<RemoveVideoFromPlaylistEvent, RemoveVideoFromPlaylistState>{
  RemoveVideoFromPlaylistBloc() : super(RemoveVideoFromPlaylistInitial()){
    on<RemoveVideoFromPlaylistRequest>(_onRemoveVideoFromPlaylistRequest);
  }

  Future<void> _onRemoveVideoFromPlaylistRequest(RemoveVideoFromPlaylistRequest event, Emitter<RemoveVideoFromPlaylistState> emit) async {
    try{
      await RemoveVideoFromPlaylistRepo().RemoveVideoFromPlaylist(event.playlistId, event.videoIds);
      emit(RemoveVideoFromPlaylistSuccess());
    }catch(e){
      emit(RemoveVideoFromPlaylistFailure(error: e.toString()));
    }
  }
}