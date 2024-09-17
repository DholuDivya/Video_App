import 'package:equatable/equatable.dart';

abstract class DownloadVideoEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DownloadVideoRequest extends DownloadVideoEvent{
  final String videoId;
  final String videoSlug;
  final String videoType;
  final String videoSource;
  final String videoThumbnail;
  final String videoTitle;
  final String videoDescription;
  final String videoHashtag;
  final String videoCreateAtHuman;
  final String videoDuration;
  final String videoViews;
  final String videoCategory;
  final String videoComments;
  final String videoLikes;
  final String channelLogo;
  final String channelName;
  final String contentType;

  DownloadVideoRequest({
  required this.videoId,
  required this.videoSlug,
  required this.videoType,
  required this.videoSource,
  required this.videoThumbnail,
  required this.videoTitle,
  required this.videoDescription,
  required this.videoHashtag,
  required this.videoCreateAtHuman,
  required this.videoDuration,
  required this.videoViews,
  required this.videoCategory,
  required this.videoComments,
  required this.videoLikes,
  required this.channelLogo,
  required this.channelName,
  required this.contentType,
});

  @override
  List<Object?> get props => [
    videoId,
    videoSlug,
    videoType,
    videoSource,
    videoThumbnail,
    videoTitle,
    videoDescription,
    videoHashtag,
    videoCreateAtHuman,
    videoDuration,
    videoViews,
    videoCategory,
    videoComments,
    videoLikes,
    channelLogo,
    channelName,
    contentType
  ];

}