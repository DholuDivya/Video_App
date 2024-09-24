import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_user_history_repo.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/model/user_history_model.dart';

class GetUserHistoryBloc extends Bloc<GetUserHistoryEvent, GetUserHistoryState>{

  int _offset = 0;
  final int _limit = 12;
  bool _hasReachedMax = false;

  GetUserHistoryBloc() : super(GetUserHistoryInitial()){
    on<GetUserHistoryRequest>(_onGetUserHistoryEvent);
    on<LoadMoreUserHistory>(_onLoadMoreUserHistory);
  }

  Future<void> _onGetUserHistoryEvent(GetUserHistoryRequest event, Emitter<GetUserHistoryState> emit) async {
    try{
      List<UserHistoryData>? userHistory = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> history = await GetUserHistoryRepo().getUserHistory(_limit, _offset);
      userHistory = List<UserHistoryData>.from(history['data'].map((data) => UserHistoryData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = userHistory.length < _limit;
      print(':):):):):):):):):):):)   $userHistory');
      emit(GetUserHistorySuccess(userHistory: userHistory, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(GetUserHistoryFailure(error: e.toString()));
    }
  }


  Future<void> _onLoadMoreUserHistory(LoadMoreUserHistory event, Emitter<GetUserHistoryState> emit) async {
    if (state is GetUserHistorySuccess && !_hasReachedMax) {
      try {
        List<UserHistoryData>? userHistory = [];
        final currentState = state as GetUserHistorySuccess;
        final updatedShortsList = List<UserHistoryData>.from(currentState.userHistory);
        Map<String, dynamic> history = await GetUserHistoryRepo().getUserHistory(_limit, _offset);
        userHistory = List<UserHistoryData>.from(history['data'].map((data) => UserHistoryData.fromJson(data)));
        _offset += _limit;
        if(userHistory.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        print('rgsdrhgusdrhsef $_hasReachedMax');
        updatedShortsList.addAll(userHistory);
        emit(GetUserHistorySuccess(userHistory: updatedShortsList, hasReachedMax: _hasReachedMax));
      } catch(e){}
    }
  }

}