import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/your_shorts_model.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_event.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_state.dart';
import 'package:vimeo_clone/model/your_shorts_model.dart';

class YourShortsBloc extends Bloc<YourShortsEvent, YourShortsState>{

  int _offset = 0;
  final int _limit = 15;
  bool _hasReachedMax = false;
  int channelId = 0;
  YourShortsBloc() : super(YourShortsInitial()){
    on<YourShortsRequest>(_onYourShortsRequest);
    on<LoadMoreYourShorts>(_onLoadMoreYourShorts);
  }

  Future<void> _onYourShortsRequest(YourShortsRequest event, Emitter<YourShortsState> emit) async {
    try{
      List<YourShortsData> yourShortsList = [];
      _offset = 0;
      _hasReachedMax = false;
      channelId = event.channelId;
      Map<String, dynamic> yourShorts = await YourShortsRepo().yourShorts(event.channelId, _limit, _offset);
      yourShortsList = List<YourShortsData>.from(yourShorts['data'].map((data) => YourShortsData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = yourShortsList.length < _limit;
      emit(YourShortsLoaded(yourShortsData: yourShortsList, hasReachedMax: _hasReachedMax,));
    }catch(e){
      emit(YourShortsFailure(error: e.toString()));
    }
  }


  Future<void> _onLoadMoreYourShorts(LoadMoreYourShorts event, Emitter<YourShortsState> emit) async {
    if (state is YourShortsLoaded && !_hasReachedMax) {
      try {
        List<YourShortsData> yourShortsList = [];
        final currentState = state as YourShortsLoaded;
        final updatedYourShortsList = List<YourShortsData>.from(currentState.yourShortsData);
        Map<String, dynamic> yourShorts = await YourShortsRepo().yourShorts(channelId, _limit, _offset);
        yourShortsList = List<YourShortsData>.from(yourShorts['data'].map((data) => YourShortsData.fromJson(data)));
        _offset += _limit;
        if(yourShortsList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        updatedYourShortsList.addAll(yourShortsList);
        emit(YourShortsLoaded(yourShortsData: updatedYourShortsList, hasReachedMax: _hasReachedMax,));
      } catch(e){
        emit(YourShortsFailure(error: e.toString()));
      }
    }
  }

}