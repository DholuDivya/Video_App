import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/user_history_repo.dart';
import 'package:vimeo_clone/bloc/add_user_history/add_user_history_event.dart';
import 'package:vimeo_clone/bloc/add_user_history/add_user_history_state.dart';

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState>{
  UserHistoryBloc() : super(UserHistoryInitial()){
    on<UserHistoryRequest>(_onUserHistoryRequest);
  }

  Future<void> _onUserHistoryRequest(UserHistoryRequest event, Emitter<UserHistoryState> emit) async {
    try{
      await UserHistoryRepo().addWatchedVideo(event.lastDuration, event.videoSlug);
      emit(UserHistorySuccess());
    }catch(e){
      emit(UserHistoryFailure(error: e.toString()));
    }
  }

}