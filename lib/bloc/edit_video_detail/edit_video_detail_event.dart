import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class EditVideoDetailEvent extends Equatable{}

class EditVideoDetailRequest extends EditVideoDetailEvent{
  final String videoSlug;
  final String? videoTitle;
  final String? videoDescription;
  final List<String>? videoHashtag;
  // final String videoStatus;
  final CroppedFile? videoThumbnail;
  final String? videoVisibility;

  EditVideoDetailRequest({
    required this.videoSlug,
    this.videoTitle,
    this.videoDescription,
    this.videoHashtag,
    this.videoThumbnail,
    this.videoVisibility
  });

  @override
  List<Object?> get props => [
    videoTitle,
    videoDescription,
    videoHashtag,
    videoThumbnail,
    videoVisibility
  ];
}