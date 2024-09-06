import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/remove_video_from_history_repo.dart';
import 'package:vimeo_clone/bloc/remove_video_from_history/remove_video_from_history_event.dart';
import 'package:vimeo_clone/bloc/remove_video_from_history/remove_video_from_history_state.dart';

class RemoveVideoFromHistoryBloc extends Bloc<RemoveVideoFromHistoryEvent, RemoveVideoFromHistoryState>{
  RemoveVideoFromHistoryBloc() : super(RemoveVideoFromHistoryInitial()){
    on<RemoveVideoFromHistoryRequest>(_onRemoveVideoFromHistoryRequest);
  }

  Future<void> _onRemoveVideoFromHistoryRequest(RemoveVideoFromHistoryRequest event, Emitter<RemoveVideoFromHistoryState> emit) async {
    try{
       await RemoveVideoFromHistoryRepo().RemoveVideoFromHistory(event.videoIds);
       emit(RemoveVideoFromHistorySuccess());
    }catch(e){
      emit(RemoveVideoFromHistoryFailure(error: e.toString()));
    }
  }
} 