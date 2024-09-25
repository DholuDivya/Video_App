import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/your_videos_repo.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';

import '../../model/your_videos_model.dart';

class YourVideosBloc extends Bloc<YourVideosEvent, YourVideosState>{
  int _offset = 0;
  final int _limit = 15;
  bool _hasReachedMax = false;
  int channelId = 0;
  YourVideosBloc() : super(YourVideosInitial()){
    on<GetYourVideosEvent>(_onGetYourVideosEvent);
    on<LoadMoreYourVideos>(_onLoadMoreYourVideos);
  }

  Future<void> _onGetYourVideosEvent(GetYourVideosEvent event, Emitter<YourVideosState> emit) async {
    emit(YourVideosLoading());
    try{
      List<YourVideosData>? yourVideoList = [];
      _offset = 0;
      _hasReachedMax = false;
      channelId = event.channelId;
      Map<String, dynamic> yourVideo = await YourVideosRepo().getYourVideos(event.channelId, _limit, _offset);
      yourVideoList = List<YourVideosData>.from(yourVideo['data'].map((data) => YourVideosData.fromJson(data)));
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
        List<YourVideosData>? yourVideoList = [];
        final currentState = state as YourVideosLoaded;
        final updatedYourVideoList = List<YourVideosData>.from(currentState.yourVideoData);
        Map<String, dynamic> yourVideo = await YourVideosRepo().getYourVideos(channelId, _limit, _offset);
        yourVideoList = List<YourVideosData>.from(yourVideo['data'].map((data) => YourVideosData.fromJson(data)));
        _offset += _limit;
        if(yourVideoList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        updatedYourVideoList.addAll(yourVideoList);
        emit(YourVideosLoaded(yourVideoData: updatedYourVideoList, hasReachedMax: _hasReachedMax));
      } catch(e){
        emit(YourVideosFailure(error: e.toString()));
      }
    }
  }

}