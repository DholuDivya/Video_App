import 'package:equatable/equatable.dart';

import '../../model/video_list_model.dart';

abstract class VideoListState extends Equatable {}

class VideoListInitial extends VideoListState {
  @override
  List<Object?> get props => [];
}

class VideoListLoading extends VideoListState {
  @override
  List<Object?> get props => [];
}

class VideoListLoaded extends VideoListState {
  final List<Videos> videoList;

  VideoListLoaded({required this.videoList});

  @override
  List<Object?> get props => [videoList];
}

class VideoListFailure extends VideoListState {
  final String error;

  VideoListFailure({required this.error});

  @override
  List<Object?> get props => [error];

}