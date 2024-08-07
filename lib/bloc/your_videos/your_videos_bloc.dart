import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/your_videos_repo.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/model/get_your_videos_model.dart';

class YourVideosBloc extends Bloc<YourVideosEvent, YourVideosState>{
  YourVideosBloc() : super(YourVideosInitial()){
    on<GetYourVideosEvent>(_onGetYourVideosEvent);
  }

  Future<void> _onGetYourVideosEvent(GetYourVideosEvent event, Emitter<YourVideosState> emit) async {
    emit(YourVideosLoading());
    try{
      final List<GetYourVideosModel>? videoData = await YourVideosRepo().getYourVideos();
      if(videoData != null){
        emit(YourVideosLoaded(videoData: videoData));
      }else{
        print('Response is Null');
      }
    }catch(e){
      emit(YourVideosFailure(error: e.toString()));
    }
  }


}