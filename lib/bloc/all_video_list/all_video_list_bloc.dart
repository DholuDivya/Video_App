import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/all_video_list_repo.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_state.dart';

import '../../model/all_video_list_model.dart';

class AllVideoListBloc extends Bloc<AllVideoListEvent, AllVideoListState>{

  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;

  AllVideoListBloc() : super(AllVideoListInitial()){
    on<GetAllVideoListEvent>(_onGetAllVideoListEvent);
    on<LoadMoreVideoList>(_onLoadMoreVideoList);
  }

  Future<void> _onGetAllVideoListEvent(GetAllVideoListEvent event, Emitter<AllVideoListState> emit) async {
    emit(AllVideoListLoading());
    try{
      List<Data>? videoList = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> video = await AllVideoListRepo().getAllVideoList(_limit, _offset);
      print('&&&&&&    ${video['data']}');
      print('iiiiiiiiiiiiiii   ');
      videoList = List<Data>.from(video['data'].map((data) => Data.fromJson(data)));
      print('99999999999      $videoList');
      _offset += _limit;
      _hasReachedMax = videoList.length < _limit;
      print('_haseReachedMax $_hasReachedMax');
      print('++++++++  $videoList');

      emit(AllVideoListLoaded(videoList: videoList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(AllVideoListFailure(error: e.toString()));
    }
  }


  Future<void> _onLoadMoreVideoList(
      LoadMoreVideoList event, Emitter<AllVideoListState> emit) async {
    if (state is AllVideoListLoaded && !_hasReachedMax) {
      try {
        List<Data>? videoList = [];
        final currentState = state as AllVideoListLoaded;
        final updatedNotes = List<Data>.from(currentState.videoList);
        Map<String, dynamic> video = await AllVideoListRepo().getAllVideoList(_limit, _offset);
        videoList = List<Data>.from(video['data'].map((data) => Data.fromJson(data)));
          _offset += _limit;

          if(videoList.length < _limit){
            _hasReachedMax = true;
          }else{
            _hasReachedMax = false;
          }

        print('rgsdrhgusdrhsef $_hasReachedMax');
          updatedNotes.addAll(videoList);
          emit(AllVideoListLoaded(
              videoList: updatedNotes, hasReachedMax: _hasReachedMax));
      } catch(e){}
    }
  }

}