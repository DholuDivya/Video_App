import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/play_video_model.dart';

abstract class PlayVideoState extends Equatable{}

class PlayVideoInitial extends PlayVideoState{
  @override
  List<Object?> get props => [];
}

class PlayVideoLoading extends PlayVideoState{
  @override
  List<Object?> get props => [];
}

class PlayVideoLoaded extends PlayVideoState{
  final List<PlayVideoModel> playVideo;

  PlayVideoLoaded({required this.playVideo});

  @override
  List<Object?> get props => [playVideo];
}

class PlayVideoFailure extends PlayVideoState{
  final String error;

  PlayVideoFailure({required this.error});

  @override
  List<Object?> get props => [error];
}