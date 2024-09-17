import 'package:equatable/equatable.dart';

abstract class UploadShortsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UploadShortsInitial extends UploadShortsState{}

class UploadShortsLoading extends UploadShortsState{}

class UploadShortsSuccess extends UploadShortsState{}

class UploadShortsFailure extends UploadShortsState{
  final String error;

  UploadShortsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}