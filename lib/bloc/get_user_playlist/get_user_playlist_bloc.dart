import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_user_playlist_repo.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

class GetUserPlaylistBloc extends Bloc<GetUserPlaylistEvent, GetUserPlaylistState>{
  GetUserPlaylistBloc() : super(GetUserPlaylistInitial()){
    on<GetUserPlaylistRequest>(_onGetUserPlaylistRequest);
  }

  Future<void> _onGetUserPlaylistRequest(GetUserPlaylistEvent event, Emitter<GetUserPlaylistState> emit) async {
    try{
      final List<GetUserPlaylistModel>? userPlaylist = await GetUserPlaylistRepo().getUserPlaylist();
      emit(GetUserPlaylistSuccess(userPlaylist: userPlaylist!));
    }catch(e){
      emit(GetUserPlaylistFailure(error: e.toString()));
    }
  }

}