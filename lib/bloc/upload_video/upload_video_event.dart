import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vimeo_clone/model/video_categories_model.dart';

abstract class UploadVideoEvent extends Equatable{}

class UploadVideoRequestEvent extends UploadVideoEvent{
  final PlatformFile video;
  final PlatformFile videoThumbnail;
  final String videoTitle;
  final String videoDescription;
  final List<int> videoCategory;
  final String? videoHashtag;
  final String videoVisibility;

  UploadVideoRequestEvent({
    required this.video,
    required this.videoThumbnail,
    required this.videoTitle,
    required this.videoDescription,
    required this.videoCategory,
    this.videoHashtag,
    required this.videoVisibility
  });

  @override
  List<Object?> get props => [videoTitle, videoDescription, videoCategory, videoHashtag, videoVisibility];
}