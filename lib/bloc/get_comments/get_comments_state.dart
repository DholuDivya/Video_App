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
  final List<GetCommentsModel> getCommentsList;

  GetCommentsLoaded({required this.getCommentsList});

  @override
  List<Object?> get props => [getCommentsList];
}

class GetCommentsFailure extends GetCommentsState{
  final String error;

  GetCommentsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}