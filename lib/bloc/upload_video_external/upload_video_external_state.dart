import 'package:equatable/equatable.dart';

abstract class UploadVideoExternalState extends Equatable{}

class UploadVideoExternalInitial extends UploadVideoExternalState{
  @override
  List<Object?> get props => [];
}

class UploadVideoExternalLoading extends UploadVideoExternalState{
  @override
  List<Object?> get props => [];
}

class UploadVideoExternalSuccess extends UploadVideoExternalState{
  @override
  List<Object?> get props => [];
}

class UploadVideoExternalFailure extends UploadVideoExternalState{
  final String error;

  UploadVideoExternalFailure({required this.error});

  @override
  List<Object?> get props => [error];
}