import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/like_dislike_repo.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_event.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_state.dart';
import 'package:vimeo_clone/model/like_dislike_video_model.dart';

class LikeDislikeVideoBloc extends Bloc<LikeDislikeVideoEvent, LikeDislikeVideoState>{
  LikeDislikeVideoBloc() : super(LikeDislikeVideoInitial()){
    on<LikeVideoRequest>(_onLikeVideoRequest);
    on<DislikeVideoRequest>(_onDislikeVideoRequest);
  }

  Future<void> _onLikeVideoRequest(LikeVideoRequest event, Emitter<LikeDislikeVideoState> emit) async {
    try{
      final List<LikeDislikeVideoModel>? likeDislike = await LikeDislikeVideoRepo().likeVideo(event.videoSlug);
      emit(LikeVideoSuccess(likeVideo: likeDislike!));
    }catch(e){
      emit(LikeVideoFailure(error: e.toString()));
    }
  }

  Future<void> _onDislikeVideoRequest(DislikeVideoRequest event, Emitter<LikeDislikeVideoState> emit) async {
    try{
      final List<LikeDislikeVideoModel>? likeDislike = await LikeDislikeVideoRepo().dislikeVideo(event.videoSlug);
      emit(DislikeVideoSuccess(dislikeVideo: likeDislike!));
    }catch(e){
      emit(DislikeVideoFailure(error: e.toString()));
    }
  }
}