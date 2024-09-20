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
  final List<Data> videoList;
  final bool hasReachedMax;

  AllVideoListLoaded({required this.videoList, required this.hasReachedMax});

  @override
  List<Object?> get props => [videoList, hasReachedMax];
}

class AllVideoListFailure extends AllVideoListState {
  final String error;

  AllVideoListFailure({required this.error});

  @override
  List<Object?> get props => [error];

}