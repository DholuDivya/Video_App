import 'package:equatable/equatable.dart';

abstract class LikeDislikeVideoEvent extends Equatable{}

class LikeVideoRequest extends LikeDislikeVideoEvent{
  final String videoSlug;

  LikeVideoRequest({required this.videoSlug});

  @override
  List<Object?> get props => [videoSlug];
}

class DislikeVideoRequest extends LikeDislikeVideoEvent{
  final String videoSlug;

  DislikeVideoRequest({required this.videoSlug});

  @override
  List<Object?> get props => [videoSlug];
}