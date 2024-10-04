import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/clear_all_history_repo.dart';
import 'package:vimeo_clone/bloc/clear_all_history/clear_all_history_event.dart';
import 'package:vimeo_clone/bloc/clear_all_history/clear_all_history_state.dart';

class ClearAllHistoryBloc extends Bloc<ClearAllHistoryEvent, ClearAllHistoryState>{
  ClearAllHistoryBloc() : super(ClearAllHistoryInitial()){
    on<ClearAllHistoryRequest>(_onClearAllHistoryRequest);
  }

  Future<void> _onClearAllHistoryRequest(ClearAllHistoryRequest event, Emitter<ClearAllHistoryState> emit) async {
    try{
      final message = await ClearAllHistoryRepo().clearAllHistory();
      emit(ClearAllHistorySuccess(message: message));
    }catch(e){
      emit(ClearAllHistoryFailure(error: e.toString()));
    }
  }

}