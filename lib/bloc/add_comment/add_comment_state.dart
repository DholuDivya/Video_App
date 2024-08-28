import 'package:equatable/equatable.dart';

abstract class AddCommentState extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddCommentInitial extends AddCommentState{}

class AddCommentLoading extends AddCommentState{}

class AddCommentSuccess extends AddCommentState{}

class AddCommentFailure extends AddCommentState{
  final String error;

  AddCommentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}