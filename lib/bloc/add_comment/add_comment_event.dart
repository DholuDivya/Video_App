import 'package:equatable/equatable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_state.dart';

abstract class AddCommentEvent extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddCommentRequest extends AddCommentEvent{
  final String videoSlug;
  final String userComment;

  AddCommentRequest({required this.userComment, required this.videoSlug});

  @override
  List<Object?> get props => [userComment, videoSlug];
}
