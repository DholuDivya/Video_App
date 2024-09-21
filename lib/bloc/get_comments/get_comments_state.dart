import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_comments_model.dart';

abstract class GetCommentsState extends Equatable{}

class GetCommentsInitial extends GetCommentsState{
  @override
  List<Object?> get props => [];
}

class GetCommentsLoading extends GetCommentsState{
  @override
  List<Object?> get props => [];
}

class GetCommentsLoaded extends GetCommentsState{
  final List<CommentData> getCommentsList;
  final bool hasReachedMax;

  GetCommentsLoaded({required this.getCommentsList, required this.hasReachedMax});

  @override
  List<Object?> get props => [getCommentsList, hasReachedMax];
}

class GetCommentsFailure extends GetCommentsState{
  final String error;

  GetCommentsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}