import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/like_dislike_video_model.dart';

abstract class LikeDislikeVideoState extends Equatable{}

class LikeDislikeVideoInitial extends LikeDislikeVideoState{
  @override
  List<Object?> get props => [];
}

class LikeDislikeVideoLoading extends LikeDislikeVideoState{
  @override
  List<Object?> get props => [];
}

class LikeVideoSuccess extends LikeDislikeVideoState{
  final List<LikeDislikeVideoModel> likeVideo;

  LikeVideoSuccess({required this.likeVideo});

  @override
  List<Object?> get props => [likeVideo];
}

class LikeVideoFailure extends LikeDislikeVideoState{
  final String error;

  LikeVideoFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class DislikeVideoSuccess extends LikeDislikeVideoState{
  final List<LikeDislikeVideoModel> dislikeVideo;

  DislikeVideoSuccess({required this.dislikeVideo});

  @override
  List<Object?> get props => [dislikeVideo];
}

class DislikeVideoFailure extends LikeDislikeVideoState{
  final String error;

  DislikeVideoFailure({required this.error});

  @override
  List<Object?> get props => [error];
}