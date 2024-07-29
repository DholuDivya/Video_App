import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/play_video_repo.dart';

import 'package:vimeo_clone/bloc/play_video/play_video_event.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_state.dart';
import 'package:vimeo_clone/model/play_video_model.dart';

class PlayVideoBloc extends Bloc<PlayVideoEvent, PlayVideoState>{
  PlayVideoBloc() : super(PlayVideoInitial()){
    on<GetVideoSlugEvent>(_onGetVideoSlugEvent);
  }
  Future<void> _onGetVideoSlugEvent(GetVideoSlugEvent event, Emitter<PlayVideoState> state) async{
    emit(PlayVideoLoading());
    print('bfkaefbuoaefaefioeiofh');
    try{
      final List<PlayVideoModel> videoData = await PlayVideoRepo().getVideo(event.slug);
      print('~~~~~~~~   ${videoData}');
      emit(PlayVideoLoaded(playVideo: videoData));
    }catch(e){
      emit(PlayVideoFailure(error: e.toString()));
    }
  }
}