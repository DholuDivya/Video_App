import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/like_dislike_comment_model.dart';

abstract class LikeDislikeCommentState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LikeDislikeCommentInitial extends LikeDislikeCommentState{}

class LikeDislikeCommentLoading extends LikeDislikeCommentState{}

class LikeCommentSuccess extends LikeDislikeCommentState{
  final List<LikeDislikeCommentModel> likedCommentData;

  LikeCommentSuccess({required this.likedCommentData});

  @override
  List<Object?> get props => [likedCommentData];
}

class LikeCommentFailure extends LikeDislikeCommentState{
  final String error;

  LikeCommentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class DislikeCommentSuccess extends LikeDislikeCommentState{
  final List<LikeDislikeCommentModel> dislikedCommentData;

  DislikeCommentSuccess({required this.dislikedCommentData});

  @override
  List<Object?> get props => [dislikedCommentData];
}

class DislikeCommentFailure extends LikeDislikeCommentState{
  final String error;

  DislikeCommentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}