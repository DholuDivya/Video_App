import 'package:equatable/equatable.dart';

import '../../model/get_your_videos_model.dart';

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
  final List<GetYourVideosModel> videoData;

  YourVideosLoaded({required this.videoData});

  @override
  List<Object?> get props => [videoData];
}

class YourVideosFailure extends YourVideosState{
  final String error;

  YourVideosFailure({required this.error});

  @override
  List<Object?> get props => [error];
}