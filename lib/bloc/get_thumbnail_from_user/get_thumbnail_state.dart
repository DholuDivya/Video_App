import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class GetThumbnailState extends Equatable{}

class GetThumbnailInitial extends GetThumbnailState{
  @override
  List<Object?> get props => [];
}

class GetThumbnailLoading extends GetThumbnailState{
  final String? previousThumbnailPath;

  GetThumbnailLoading({this.previousThumbnailPath});

  @override
  List<Object?> get props => [previousThumbnailPath];
}

class GetThumbnailSuccess extends GetThumbnailState{
  final PlatformFile? videoThumbnail;


  GetThumbnailSuccess({this.videoThumbnail});

  @override
  List<Object?> get props => [videoThumbnail];
}

class GetThumbnailFailure extends GetThumbnailState{
  final String error;

  GetThumbnailFailure({required this.error});

  @override
  List<Object?> get props => [error];
}