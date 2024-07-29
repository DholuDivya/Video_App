import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';

class YourVideosBloc extends Bloc<YourVideosEvent, YourVideosState>{
  YourVideosBloc() : super(YourVideosInitial()){
    on<GetYourVideosEvent>(_onGetYourVideosEvent);
  }

  Future<void> _onGetYourVideosEvent(GetYourVideosEvent event, Emitter<YourVideosState> emit) async {
    emit(YourVideosLoading());
    try{

    }catch(e){
      emit(YourVideosFailure(error: e.toString()));
    }
  }


}