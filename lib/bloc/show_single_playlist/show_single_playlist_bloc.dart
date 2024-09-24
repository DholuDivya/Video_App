import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/show_single_playlist_repo.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_event.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_state.dart';
import 'package:vimeo_clone/model/show_single_playlist_model.dart';

class ShowSinglePlaylistBloc extends Bloc<ShowSinglePlaylistEvent, ShowSinglePlaylistState> {

  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;
  var playlistTitle = '';
  var playlistVisibility = '';

  ShowSinglePlaylistBloc() : super(ShowSinglePlaylistInitial()) {
    on<ShowSinglePlaylistRequest>(_onShowSinglePlaylistRequest);
    // on<LoadMoreSinglePlaylist>(_onLoadMoreSinglePlaylist);
  }

  Future<void> _onShowSinglePlaylistRequest(ShowSinglePlaylistRequest event,
      Emitter<ShowSinglePlaylistState> emit) async {
    try {
      List<SinglePlaylistVideos>? singlePlaylistData = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> playlistData = await ShowSinglePlaylistRepo().showSinglePlaylist(event.playlistId, _limit, _offset);
      print('uuiuiiuuiiuuuuuuuuuuu   ');
      playlistTitle = playlistData['playlist']['title'];
      playlistVisibility = playlistData['playlist']['visibility'];

      singlePlaylistData = List<SinglePlaylistVideos>.from(playlistData['playlist']['videos'].map((data) => SinglePlaylistVideos.fromJson(data)));
      print('uuiuiiuuiiuuuuuuuuuuu   $singlePlaylistData');
      _offset += _limit;
      _hasReachedMax = singlePlaylistData.length < _limit;
      emit(ShowSinglePlaylistLoaded(singlePlaylistData: singlePlaylistData, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(ShowSinglePlaylistFailure(error: e.toString()));
    }
  }


  // Future<void> _onLoadMoreSinglePlaylist(LoadMoreSinglePlaylist event, Emitter<ShowSinglePlaylistState> emit) async {
  //   if (state is ShowSinglePlaylistLoaded && !_hasReachedMax) {
  //     try {
  //       List<ShowSinglePlaylistState>? yourVideoList = [];
  //       final currentState = state as ShowSinglePlaylistLoaded;
  //       final updatedVideoList = List<ShowSinglePlaylistState>.from(currentState.yourVideoData);
  //       Map<String, dynamic> yourVideo = await YourVideosRepo().getYourVideos(_limit, _offset);
  //       yourVideoList = List<GetYourVideosModel>.from(yourVideo['data'].map((data) => GetYourVideosModel.fromJson(data)));
  //       _offset += _limit;
  //       if(yourVideoList.length < _limit){
  //         _hasReachedMax = true;
  //       }else{
  //         _hasReachedMax = false;
  //       }
  //       updatedVideoList.addAll(yourVideoList);
  //       emit(YourVideosLoaded(yourVideoData: yourVideoList, hasReachedMax: _hasReachedMax));
  //     } catch(e){
  //       emit(YourVideosFailure(error: e.toString()));
  //     }
  //   }
  // }

}
