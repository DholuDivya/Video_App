import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class UploadVideoExternalEvent extends Equatable{}

class UploadVideoExternalRequest extends UploadVideoExternalEvent{
  final String videoExternalUrl;
  final CroppedFile videoThumbnail;
  final String videoTitle;
  final String videoDescription;
  final List<int> videoCategory;
  final String? videoHashtag;
  final String videoVisibility;

  UploadVideoExternalRequest({
    required this.videoExternalUrl,
    required this.videoThumbnail,
    required this.videoTitle,
    required this.videoDescription,
    required this.videoCategory,
    this.videoHashtag,
    required this.videoVisibility
});

  @override
  List<Object?> get props => [
    videoExternalUrl,
    videoThumbnail,
    videoTitle,
    videoDescription,
    videoCategory,
    videoHashtag,
    videoVisibility
  ];
}