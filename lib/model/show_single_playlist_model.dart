class ShowSinglePlaylistModel {
  bool? error;
  String? message;
  Playlist? playlist;

  ShowSinglePlaylistModel({this.error, this.message, this.playlist});

  ShowSinglePlaylistModel.fromJson(Map<String, dynamic> json) {
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
  String? visibility;
  String? createdAtHuman;
  List<SinglePlaylistVideos>? videos;

  Playlist(
      {this.id,
        this.title,
        this.description,
        this.visibility,
        this.createdAtHuman,
        this.videos});

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    visibility = json['visibility'];
    createdAtHuman = json['created_at_human'];
    if (json['videos'] != null) {
      videos = <SinglePlaylistVideos>[];
      json['videos'].forEach((v) {
        videos!.add(new SinglePlaylistVideos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['visibility'] = this.visibility;
    data['created_at_human'] = this.createdAtHuman;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SinglePlaylistVideos {
  int? id;
  String? type;
  String? title;
  String? slug;
  String? description;
  String? hashtag;
  String? watchHours;
  int? videoType;
  Null? geoRegion;
  Null? metaKeywords;
  Null? metaDescription;
  String? source;
  String? sourceType;
  int? duration;
  String? thumbnails;
  int? nSFW;
  Null? scheduling;
  int? scheduled;
  int? commentsOnOff;
  int? channelId;
  String? status;
  Null? deletedAt;
  int? views;
  int? likes;
  String? visibility;
  int? comments;
  String? createdAt;
  String? updatedAt;
  String? contentType;
  Null? reasonForDeactivation;
  String? videoUrl;
  String? createdAtHuman;
  Channel? channel;
  Pivot? pivot;

  SinglePlaylistVideos(
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
        this.channel,
        this.pivot});

  SinglePlaylistVideos.fromJson(Map<String, dynamic> json) {
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
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
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
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? logo;
  String? createdAtHuman;

  Channel(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.logo,
        this.createdAtHuman});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    logo = json['logo'];
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['logo'] = this.logo;
    data['created_at_human'] = this.createdAtHuman;
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
