import 'package:equatable/equatable.dart';

abstract class DownloadVideoState extends Equatable{
  @override
  List<Object?> get props => [];
}

class DownloadVideoInitial extends DownloadVideoState{}

class DownloadVideoInProgress extends DownloadVideoState{
  final double progress;

  DownloadVideoInProgress({required this.progress});

  @override
  List<Object?> get props => [progress];
}

class DownloadVideoSuccess extends DownloadVideoState{}

class DownloadVideoFailure extends DownloadVideoState{
  final String error;

  DownloadVideoFailure({required this.error});

  @override
  List<Object?> get props => [error];
}