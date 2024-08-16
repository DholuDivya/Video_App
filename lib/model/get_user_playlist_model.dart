class GetUserPlaylistModel {
  List<Playlist>? playlists;

  GetUserPlaylistModel({this.playlists});

  GetUserPlaylistModel.fromJson(Map<String, dynamic> json) {
    if (json['playlists'] != null) {
      playlists = <Playlist>[];
      json['playlists'].forEach((v) {
        playlists!.add(Playlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlist {
  int? id;
  String? title;
  String? description;
  int? userId;
  String? visibility;
  String? createdAt;
  String? updatedAt;
  String? createdAtHuman;
  List<Video>? videos; // Now a list of Video objects

  Playlist({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.visibility,
    this.createdAt,
    this.updatedAt,
    this.createdAtHuman,
    this.videos,
  });

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    visibility = json['visibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdAtHuman = json['created_at_human'];
    if (json['videos'] != null) {
      videos = <Video>[];
      json['videos'].forEach((v) {
        videos!.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['user_id'] = userId;
    data['visibility'] = visibility;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_at_human'] = createdAtHuman;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int? id;
  String? type;
  String? title;
  String? slug;
  String? description;
  String? hashtag;
  String? watchHours;
  int? videoType;
  String? source;
  String? sourceType;
  int? duration;
  String? thumbnails;
  int? nsfw;
  int? commentsOnOff;
  int? channelId;
  String? status;
  int? views;
  int? likes;
  String? visibility;
  int? comments;
  String? createdAt;
  String? updatedAt;
  String? createdAtHuman;
  String? videoUrl;
  Pivot? pivot; // Added pivot object

  Video({
    this.id,
    this.type,
    this.title,
    this.slug,
    this.description,
    this.hashtag,
    this.watchHours,
    this.videoType,
    this.source,
    this.sourceType,
    this.duration,
    this.thumbnails,
    this.nsfw,
    this.commentsOnOff,
    this.channelId,
    this.status,
    this.views,
    this.likes,
    this.visibility,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.createdAtHuman,
    this.videoUrl,
    this.pivot,
  });

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    hashtag = json['hashtag'];
    watchHours = json['watch_hours'];
    videoType = json['video_type'];
    source = json['source'];
    sourceType = json['source_type'];
    duration = json['duration'];
    thumbnails = json['thumbnails'];
    nsfw = json['NSFW'];
    commentsOnOff = json['comments_on_off'];
    channelId = json['channel_id'];
    status = json['status'];
    views = json['views'];
    likes = json['likes'];
    visibility = json['visibility'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdAtHuman = json['created_at_human'];
    videoUrl = json['video_url'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['hashtag'] = hashtag;
    data['watch_hours'] = watchHours;
    data['video_type'] = videoType;
    data['source'] = source;
    data['source_type'] = sourceType;
    data['duration'] = duration;
    data['thumbnails'] = thumbnails;
    data['NSFW'] = nsfw;
    data['comments_on_off'] = commentsOnOff;
    data['channel_id'] = channelId;
    data['status'] = status;
    data['views'] = views;
    data['likes'] = likes;
    data['visibility'] = visibility;
    data['comments'] = comments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_at_human'] = createdAtHuman;
    data['video_url'] = videoUrl;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? playlistId;
  int? videoId;

  Pivot({this.playlistId, this.videoId});

  Pivot.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    videoId = json['videos_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['playlist_id'] = playlistId;
    data['videos_id'] = videoId;
    return data;
  }
}
