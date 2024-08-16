class GetChannelDetailModel {
  Channel? channel;
  String? createdAtHumanChannels;
  bool? isAssociated;
  bool? isSubscribed;
  int? videoCount;
  int? subscriberCount;
  List<SuggestedVideos>? suggestedVideos;
  List<Playlist>? playlists;

  GetChannelDetailModel(
      {this.channel,
        this.createdAtHumanChannels,
        this.isAssociated,
        this.isSubscribed,
        this.videoCount,
        this.subscriberCount,
        this.suggestedVideos,
        this.playlists});

  GetChannelDetailModel.fromJson(Map<String, dynamic> json) {
    channel =
    json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    createdAtHumanChannels = json['created_at_human_channels'];
    isAssociated = json['is_associated'];
    isSubscribed = json['is_subscribed'];
    videoCount = json['video_count'];
    subscriberCount = json['subscriber_count'];
    if (json['suggested_videos'] != null) {
      suggestedVideos = <SuggestedVideos>[];
      json['suggested_videos'].forEach((v) {
        suggestedVideos!.add(SuggestedVideos.fromJson(v));
      });
    }
    if (json['playlists'] != null) {
      playlists = <Playlist>[];
      json['playlists'].forEach((v) {
        playlists!.add(Playlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    data['created_at_human_channels'] = createdAtHumanChannels;
    data['is_associated'] = isAssociated;
    data['is_subscribed'] = isSubscribed;
    data['video_count'] = videoCount;
    data['subscriber_count'] = subscriberCount;
    if (suggestedVideos != null) {
      data['suggested_videos'] =
          suggestedVideos!.map((v) => v.toJson()).toList();
    }
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? logo;
  String? bannerImage;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Videos>? videos;

  Channel(
      {this.id,
        this.name,
        this.slug,
        this.description,
        this.logo,
        this.bannerImage,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.videos});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    logo = json['logo'];
    bannerImage = json['banner_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['logo'] = logo;
    data['banner_image'] = bannerImage;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
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
  int? nSFW;
  int? scheduled;
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
  List<Categories>? categories;

  Videos(
      {this.id,
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
        this.nSFW,
        this.scheduled,
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
        this.categories});

  Videos.fromJson(Map<String, dynamic> json) {
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
    nSFW = json['NSFW'];
    scheduled = json['scheduled'];
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
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['NSFW'] = nSFW;
    data['scheduled'] = scheduled;
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
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  int? parentId;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? status;
  Pivot? pivot;

  Categories(
      {this.id,
        this.name,
        this.parentId,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? videoId;
  int? categoryId;

  Pivot({this.videoId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['video_id'] = videoId;
    data['category_id'] = categoryId;
    return data;
  }
}

class SuggestedVideos {
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
  int? nsfw;
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
  String? createdAtHuman;

  SuggestedVideos({
    this.id,
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
    this.nsfw,
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
    this.createdAtHuman,
  });

  SuggestedVideos.fromJson(Map<String, dynamic> json) {
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
    nsfw = json['NSFW'];
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
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['hashtag'] = hashtag;
    data['watch_hours'] = watchHours;
    data['video_type'] = videoType;
    data['geo_region'] = geoRegion;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['source'] = source;
    data['source_type'] = sourceType;
    data['duration'] = duration;
    data['thumbnails'] = thumbnails;
    data['NSFW'] = nsfw;
    data['scheduling'] = scheduling;
    data['scheduled'] = scheduled;
    data['comments_on_off'] = commentsOnOff;
    data['channel_id'] = channelId;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['views'] = views;
    data['likes'] = likes;
    data['visibility'] = visibility;
    data['comments'] = comments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['content_type'] = contentType;
    data['created_at_human'] = createdAtHuman;
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

  Playlist({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.visibility,
    this.createdAt,
    this.updatedAt,
  });

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    visibility = json['visibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['user_id'] = userId;
    data['visibility'] = visibility;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
