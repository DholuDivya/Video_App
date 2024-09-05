import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class EditVideoDetailEvent extends Equatable{}

class EditVideoDetailRequest extends EditVideoDetailEvent{
  final String videoTitle;
  final String videoDescription;
  final List<String> videoHashtag;
  // final String videoStatus;
  final CroppedFile videoThumbnail;
  final String videoVisibility;

  EditVideoDetailRequest({
    required this.videoTitle,
    required this.videoDescription,
    required this.videoHashtag,
    required this.videoThumbnail,
    required this.videoVisibility
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