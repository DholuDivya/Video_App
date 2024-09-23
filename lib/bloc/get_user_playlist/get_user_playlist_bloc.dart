import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_user_playlist_repo.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

class GetUserPlaylistBloc extends Bloc<GetUserPlaylistEvent, GetUserPlaylistState>{

  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;

  GetUserPlaylistBloc() : super(GetUserPlaylistInitial()){
    on<GetUserPlaylistRequest>(_onGetUserPlaylistRequest);
    on<LoadMoreUserPlaylist>(_onLoadMoreUserPlaylist);
  }

  Future<void> _onGetUserPlaylistRequest(GetUserPlaylistEvent event, Emitter<GetUserPlaylistState> emit) async {
    try{
      List<Playlist>? userPlaylistList = [];
      _offset = 0;
      _hasReachedMax = false;
      print('GGGGGGGGGGGGGGGGGGGGGGGGG');
      Map<String, dynamic> playlistData = await GetUserPlaylistRepo().getUserPlaylist(_limit, _offset);
      print('||||||||||||||||||||||||||||| $playlistData');
      userPlaylistList = List<Playlist>.from(playlistData['data'].map((data) => Playlist.fromJson(data)));
      print('000...................................');
      _offset += _limit;
      _hasReachedMax = userPlaylistList.length < _limit;
      print('Fetched successfully ::::::::::::       $userPlaylistList');
      emit(GetUserPlaylistSuccess(userPlaylist: userPlaylistList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(GetUserPlaylistFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreUserPlaylist(LoadMoreUserPlaylist event, Emitter<GetUserPlaylistState> emit) async {
    if (state is GetUserPlaylistSuccess && !_hasReachedMax) {
      try {
        List<Playlist>? userPlaylistList = [];
        final currentState = state as GetUserPlaylistSuccess;
        final updatedPlaylist = List<Playlist>.from(currentState.userPlaylist);
        Map<String, dynamic> playlistData = await GetUserPlaylistRepo().getUserPlaylist(_limit, _offset);
        userPlaylistList = List<Playlist>.from(playlistData['data'].map((data) => Playlist.fromJson(data)));
        _offset += _limit;
        if(userPlaylistList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        print('rgsdrhgusdrhsef $_hasReachedMax');
        updatedPlaylist.addAll(userPlaylistList);
        emit(GetUserPlaylistSuccess(userPlaylist: userPlaylistList, hasReachedMax: _hasReachedMax));
      } catch(e){
        emit(GetUserPlaylistFailure(error: e.toString()));
      }
    }
  }

}