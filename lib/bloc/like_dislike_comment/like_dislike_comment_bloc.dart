import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/like_dislike_comment_repo.dart';
import 'package:vimeo_clone/bloc/like_dislike_comment/like_dislike_comment_event.dart';
import 'package:vimeo_clone/bloc/like_dislike_comment/like_dislike_comment_state.dart';
import 'package:vimeo_clone/model/like_dislike_comment_model.dart';

class LikeDislikeCommentBloc extends Bloc<LikeDislikeCommentEvent, LikeDislikeCommentState>{
  LikeDislikeCommentBloc() : super(LikeDislikeCommentInitial()){
    on<LikeCommentRequest>(_onLikeCommentRequest);
    on<DislikeCommentRequest>(_onDislikeCommentRequest);
  }

  Future<void> _onLikeCommentRequest(LikeCommentRequest event, Emitter<LikeDislikeCommentState> emit) async {
    try{
      final List<LikeDislikeCommentModel>? likeCommentData = await LikeDislikeCommentRepo().likeComment(event.commentId);
      emit(LikeCommentSuccess(likedCommentData: likeCommentData!));
    }catch(e){
      emit(LikeCommentFailure(error: e.toString()));
    }
  }

  Future<void> _onDislikeCommentRequest(DislikeCommentRequest event, Emitter<LikeDislikeCommentState> emit) async {
    try{
      final List<LikeDislikeCommentModel>? dislikeCommentData = await LikeDislikeCommentRepo().dislikeComment(event.commentId);
      emit(DislikeCommentSuccess(dislikedCommentData: dislikeCommentData!));
    }catch(e){
      emit(DislikeCommentFailure(error: e.toString()));
    }
  }
}