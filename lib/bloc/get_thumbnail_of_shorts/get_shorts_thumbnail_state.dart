import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class GetShortsThumbnailState extends Equatable{}

class GetShortsThumbnailInitial extends GetShortsThumbnailState{
  @override
  List<Object?> get props => [];
}

class GetShortsThumbnailLoading extends GetShortsThumbnailState{
  @override
  List<Object?> get props => [];
}

class GetShortsThumbnailSuccess extends GetShortsThumbnailState{
  final CroppedFile shortThumbnail;

  GetShortsThumbnailSuccess({required this.shortThumbnail});

  @override
  List<Object?> get props => [];
}

class GetShortsThumbnailFailure extends GetShortsThumbnailState{
  final String error;

  GetShortsThumbnailFailure({required this.error});

  @override
  List<Object?> get props => [error];
}