class GetYourVideosModel {
  Channel? channel;
  bool? isAssociated;
  bool? isSubscribed;
  String? createdAtHumanChannels;
  int? videoCount;
  int? subscriberCount;

  GetYourVideosModel({
    this.channel,
    this.isAssociated,
    this.isSubscribed,
    this.createdAtHumanChannels,
    this.videoCount,
    this.subscriberCount,
  });

  GetYourVideosModel.fromJson(Map<String, dynamic> json) {
    channel = json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    isAssociated = json['is_associated'];
    isSubscribed = json['is_subscribed'];
    createdAtHumanChannels = json['created_at_human_channels'];
    videoCount = json['video_count'];
    subscriberCount = json['subscriber_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    data['is_associated'] = isAssociated;
    data['is_subscribed'] = isSubscribed;
    data['created_at_human_channels'] = createdAtHumanChannels;
    data['video_count'] = videoCount;
    data['subscriber_count'] = subscriberCount;
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
  String? deletedAt;
  String? region;
  String? createdAt;
  String? updatedAt;
  List<Videos>? videos;

  Channel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.logo,
    this.bannerImage,
    this.status,
    this.deletedAt,
    this.region,
    this.createdAt,
    this.updatedAt,
    this.videos,
  });

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    logo = json['logo'];
    bannerImage = json['banner_image'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    region = json['region'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['logo'] = logo;
    data['banner_image'] = bannerImage;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['region'] = region;
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
  int? watchHours;
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
  String? createdAtHuman;

  Videos({
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
    this.createdAtHuman,
  });

  Videos.fromJson(Map<String, dynamic> json) {
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
    createdAtHuman = json['created_at_human'];
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
    data['geo_region'] = geoRegion;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['source'] = source;
    data['source_type'] = sourceType;
    data['duration'] = duration;
    data['thumbnails'] = thumbnails;
    data['NSFW'] = nSFW;
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
    data['created_at_human'] = createdAtHuman;
    return data;
  }
}
