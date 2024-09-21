import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_shorts_by_slug_repo.dart';
import 'package:vimeo_clone/Repo/get_shorts_list_repo.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_state.dart';
import 'package:vimeo_clone/model/get_shorts_by_slug_model.dart';
import 'package:vimeo_clone/model/get_shorts_list_model.dart';

class GetShortsListBloc extends Bloc<GetShortsListEvent, GetShortsListState>{

  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;

  GetShortsListBloc() : super(GetShortsListInitial()){
    on<GetShortsListRequest>(_onGetShortsListRequest);
    on<GetShortsBySlugRequest>(_onGetShortsBySlug);
    on<LoadMoreShortsList>(_onLoadMoreShortsList);
  }

  Future<void> _onGetShortsListRequest(GetShortsListRequest event, Emitter<GetShortsListState> emit) async {
    emit(GetShortsListLoading());
    try{
      List<ShortsListData>? shortsList = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> shorts = await GetShortsListRepo().getShortsList(_limit, _offset);
      shortsList = List<ShortsListData>.from(shorts['data'].map((data) => ShortsListData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = shortsList.length < _limit;
      print('<<<<<<<<<<<<<<<<<<   $shortsList');
      emit(GetShortsListLoaded(shortsList: shortsList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(GetShortsListFailure(error: e.toString()));
    }
  }


  Future<void> _onGetShortsBySlug(GetShortsBySlugRequest event, Emitter<GetShortsListState> emit) async {
    try{
      final List<GetShortsListModel>? shortsData = await GetShortsBySlugRepo().getShortsBySlug(event.shortsSlug);
      print('>>>>>>>>>>>>>>>>>>    $shortsData');
      emit(GetShortsBySlugLoaded(shortsData: shortsData!));
    }catch(e){
      emit(GetShortsBySlugFailure(error: e.toString()));
    }
  }


  Future<void> _onLoadMoreShortsList(LoadMoreShortsList event, Emitter<GetShortsListState> emit) async {
    if (state is GetShortsListLoaded && !_hasReachedMax) {
      try {
        List<ShortsListData>? shortsList = [];
        final currentState = state as GetShortsListLoaded;
        final updatedShortsList = List<ShortsListData>.from(currentState.shortsList);
        Map<String, dynamic> shorts = await GetShortsListRepo().getShortsList(_limit, _offset);
        shortsList = List<ShortsListData>.from(shorts['data'].map((data) => ShortsListData.fromJson(data)));
        _offset += _limit;
        if(shortsList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        print('rgsdrhgusdrhsef $_hasReachedMax');
        updatedShortsList.addAll(shortsList);
        emit(GetShortsListLoaded(shortsList: updatedShortsList, hasReachedMax: _hasReachedMax));
      } catch(e){}
    }
  }


}