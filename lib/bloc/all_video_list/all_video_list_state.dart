import 'package:equatable/equatable.dart';

import '../../model/all_video_list_model.dart';


abstract class AllVideoListState extends Equatable{}

class AllVideoListInitial extends AllVideoListState {
  @override
  List<Object?> get props => [];
}

class AllVideoListLoading extends AllVideoListState {
  @override
  List<Object?> get props => [];
}

class AllVideoListLoaded extends AllVideoListState {
  final List<VideoData> videoList;

  AllVideoListLoaded({required this.videoList});

  @override
  List<Object?> get props => [videoList];
}

class AllVideoListFailure extends AllVideoListState {
  final String error;

  AllVideoListFailure({required this.error});

  @override
  List<Object?> get props => [error];

}