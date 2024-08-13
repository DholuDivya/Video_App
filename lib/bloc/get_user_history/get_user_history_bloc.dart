import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_user_history_repo.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/model/user_history_model.dart';

class GetUserHistoryBloc extends Bloc<GetUserHistoryEvent, GetUserHistoryState>{
  GetUserHistoryBloc() : super(GetUserHistoryInitial()){
    on<GetUserHistoryRequest>(_onGetUserHistoryEvent);
  }

  Future<void> _onGetUserHistoryEvent(GetUserHistoryRequest event, Emitter<GetUserHistoryState> emit) async {
    try{
      final List<UserHistoryModel>? userHistory = await GetUserHistoryRepo().getUserHistory();
      print(':):):):):):):):):):):)   $userHistory');
      emit(GetUserHistorySuccess(userHistory: userHistory!));
    }catch(e){
      emit(GetUserHistoryFailure(error: e.toString()));
    }
  }

}