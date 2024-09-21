import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/your_videos_repo.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/model/get_your_videos_model.dart';

class YourVideosBloc extends Bloc<YourVideosEvent, YourVideosState>{
  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;
  YourVideosBloc() : super(YourVideosInitial()){
    on<GetYourVideosEvent>(_onGetYourVideosEvent);
    on<LoadMoreYourVideos>(_onLoadMoreYourVideos);
  }

  Future<void> _onGetYourVideosEvent(GetYourVideosEvent event, Emitter<YourVideosState> emit) async {
    emit(YourVideosLoading());
    try{
      List<YourVideoData>? yourVideoList = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> yourVideo = await YourVideosRepo().getYourVideos(_limit, _offset);
      yourVideoList = List<YourVideoData>.from(yourVideo['data'].map((data) => YourVideoData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = yourVideoList.length < _limit;
      emit(YourVideosLoaded(yourVideoData: yourVideoList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(YourVideosFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreYourVideos(LoadMoreYourVideos event, Emitter<YourVideosState> emit) async {
    if (state is YourVideosLoaded && !_hasReachedMax) {
      try {
        List<YourVideoData>? yourVideoList = [];
        final currentState = state as YourVideosLoaded;
        final updatedVideoList = List<YourVideoData>.from(currentState.yourVideoData);
        Map<String, dynamic> yourVideo = await YourVideosRepo().getYourVideos(_limit, _offset);
        yourVideoList = List<YourVideoData>.from(yourVideo['data'].map((data) => YourVideoData.fromJson(data)));
        _offset += _limit;
        if(yourVideoList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        updatedVideoList.addAll(yourVideoList);
        emit(YourVideosLoaded(yourVideoData: yourVideoList, hasReachedMax: _hasReachedMax));
      } catch(e){
        emit(YourVideosFailure(error: e.toString()));
      }
    }
  }

}