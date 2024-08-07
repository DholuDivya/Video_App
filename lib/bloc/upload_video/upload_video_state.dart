import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_state.dart';

abstract class UploadVideoState extends Equatable{}

class UploadVideoInitial extends UploadVideoState{
  @override
  List<Object?> get props => [];
}

class UploadVideoLoading extends UploadVideoState{
  @override
  List<Object?> get props => [];
}

class UploadVideoSuccess extends UploadVideoState{
  @override
  List<Object?> get props => [];
}

class UploadVideoFailure extends UploadVideoState{
  final String error;

  UploadVideoFailure({required this.error});

  @override
  List<Object?> get props => [];
}