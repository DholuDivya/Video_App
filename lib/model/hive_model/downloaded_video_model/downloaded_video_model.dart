import 'package:hive/hive.dart';
part 'downloaded_video_model.g.dart';

@HiveType(typeId: 1)
class DownloadedVideoModel{
  @HiveField(0)
  String? videoId;

  @HiveField(1)
  String? videoSlug;

  @HiveField(2)
  String? videoType;

  @HiveField(3)
  String? videoSource;

  @HiveField(4)
  String? videoThumbnail;

  @HiveField(5)
  String? videoTitle;

  @HiveField(6)
  String? videoDescription;

  @HiveField(7)
  String? videoHashtag;

  @HiveField(8)
  String? videoCreateAtHuman;

  @HiveField(9)
  String? videoDuration;

  @HiveField(10)
  String? videoViews;

  @HiveField(11)
  String? videoCategory;

  @HiveField(12)
  String? videoComments;

  @HiveField(13)
  String? videoLikes;

  @HiveField(14)
  String? channelLogo;

  @HiveField(15)
  String? channelName;

  @HiveField(16)
  String? contentType;

  DownloadedVideoModel({
    this.videoId,
    this.videoSlug,
    this.videoType,
    this.videoSource,
    this.videoThumbnail,
    this.videoTitle,
    this.videoDescription,
    this.videoHashtag,
    this.videoCreateAtHuman,
    this.videoDuration,
    this.videoViews,
    this.videoCategory,
    this.videoComments,
    this.videoLikes,
    this.channelLogo,
    this.channelName,
    this.contentType
  });
}