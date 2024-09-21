import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vimeo_clone/model/get_your_videos_model.dart';

import '../../model/get_channel_detail_model.dart';

abstract class YourVideosState extends Equatable{}

class YourVideosInitial extends YourVideosState{
  @override
  List<Object?> get props => [];
}

class YourVideosLoading extends YourVideosState{
  @override
  List<Object?> get props => [];
}

class YourVideosLoaded extends YourVideosState{
  final List<YourVideoData> yourVideoData;
  final bool hasReachedMax;

  YourVideosLoaded({required this.yourVideoData, required this.hasReachedMax});

  @override
  List<Object?> get props => [yourVideoData, hasReachedMax];
}

class YourVideosFailure extends YourVideosState{
  final String error;

  YourVideosFailure({required this.error});

  @override
  List<Object?> get props => [error];
}