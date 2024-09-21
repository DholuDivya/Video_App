class GetUserPlaylistModel {
  bool? error;
  String? message;
  Playlist? playlist;

  GetUserPlaylistModel({this.error, this.message, this.playlist});

  GetUserPlaylistModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    playlist = json['playlist'] != null
        ? new Playlist.fromJson(json['playlist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.playlist != null) {
      data['playlist'] = this.playlist!.toJson();
    }
    return data;
  }
}

class Playlist {
  int? id;
  String? title;
  String? description;
  String? status;
  String? createdAtHuman;
  List<PlaylistVideos>? videos;

  Playlist(
      {this.id,
        this.title,
        this.description,
        this.status,
        this.createdAtHuman,
        this.videos});

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAtHuman = json['created_at_human'];
    if (json['videos'] != null) {
      videos = <PlaylistVideos>[];
      json['videos'].forEach((v) {
        videos!.add(new PlaylistVideos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at_human'] = this.createdAtHuman;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaylistVideos {
  int? id;
  String? type;
  String? title;
  String? slug;
  String? description;
  String? hashtag;
  String? watchHours;
  int? videoType;
  String? geoRegion;
  String? metaKeywords;
  String? metaDescription;
  String? source;
  String? sourceType;
  int? duration;
  String? thumbnails;
  int? nSFW;
  String? scheduling;
  int? scheduled;
  int? commentsOnOff;
  int? channelId;
  String? status;
  String? deletedAt;
  int? views;
  int? likes;
  String? visibility;
  int? comments;
  String? createdAt;
  String? updatedAt;
  String? contentType;
  String? reasonForDeactivation;
  String? videoUrl;
  String? createdAtHuman;
  Pivot? pivot;

  PlaylistVideos(
      {this.id,
        this.type,
        this.title,
        this.slug,
        this.description,
        this.hashtag,
        this.watchHours,
        this.videoType,
        this.geoRegion,
        this.metaKeywords,
        this.metaDescription,
        this.source,
        this.sourceType,
        this.duration,
        this.thumbnails,
        this.nSFW,
        this.scheduling,
        this.scheduled,
        this.commentsOnOff,
        this.channelId,
        this.status,
        this.deletedAt,
        this.views,
        this.likes,
        this.visibility,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.contentType,
        this.reasonForDeactivation,
        this.videoUrl,
        this.createdAtHuman,
        this.pivot});

  PlaylistVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    hashtag = json['hashtag'];
    watchHours = json['watch_hours'];
    videoType = json['video_type'];
    geoRegion = json['geo_region'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    source = json['source'];
    sourceType = json['source_type'];
    duration = json['duration'];
    thumbnails = json['thumbnails'];
    nSFW = json['NSFW'];
    scheduling = json['scheduling'];
    scheduled = json['scheduled'];
    commentsOnOff = json['comments_on_off'];
    channelId = json['channel_id'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    views = json['views'];
    likes = json['likes'];
    visibility = json['visibility'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentType = json['content_type'];
    reasonForDeactivation = json['reason_for_deactivation'];
    videoUrl = json['video_url'];
    createdAtHuman = json['created_at_human'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['watch_hours'] = this.watchHours;
    data['video_type'] = this.videoType;
    data['geo_region'] = this.geoRegion;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['source'] = this.source;
    data['source_type'] = this.sourceType;
    data['duration'] = this.duration;
    data['thumbnails'] = this.thumbnails;
    data['NSFW'] = this.nSFW;
    data['scheduling'] = this.scheduling;
    data['scheduled'] = this.scheduled;
    data['comments_on_off'] = this.commentsOnOff;
    data['channel_id'] = this.channelId;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['visibility'] = this.visibility;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_type'] = this.contentType;
    data['reason_for_deactivation'] = this.reasonForDeactivation;
    data['video_url'] = this.videoUrl;
    data['created_at_human'] = this.createdAtHuman;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? playlistId;
  int? videosId;

  Pivot({this.playlistId, this.videosId});

  Pivot.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    videosId = json['videos_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlist_id'] = this.playlistId;
    data['videos_id'] = this.videosId;
    return data;
  }
}
