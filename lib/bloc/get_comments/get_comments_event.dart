import 'package:equatable/equatable.dart';

abstract class GetCommentsEvent extends Equatable{}

class GetCommentsRequest extends GetCommentsEvent{
  final String videoSlug;

  GetCommentsRequest({required this.videoSlug});

  @override
  List<Object?> get props => [videoSlug];
}


class LoadMoreGetComments extends GetCommentsEvent{
  @override
  List<Object?> get props => [];
}