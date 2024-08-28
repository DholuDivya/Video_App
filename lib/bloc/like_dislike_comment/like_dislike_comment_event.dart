import 'package:equatable/equatable.dart';

abstract class LikeDislikeCommentEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LikeCommentRequest extends LikeDislikeCommentEvent{
  final int commentId;

  LikeCommentRequest({required this.commentId});

  @override
  List<Object?> get props => [];
}

class DislikeCommentRequest extends LikeDislikeCommentEvent{
  final int commentId;

  DislikeCommentRequest({required this.commentId});

  @override
  List<Object?> get props => [];
}