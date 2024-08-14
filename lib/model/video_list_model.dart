class VideoListModel {
  String? message;
  Category? category;

  VideoListModel({this.message, this.category});

  VideoListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? parentId;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? status;
  List<Videos>? videos;

  Category(
      {this.id,
        this.name,
        this.parentId,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.videos});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
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
  String? createdAtHuman;
  Pivot? pivot;
  Channel? channel;

  Videos(
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
        this.createdAtHuman,
        this.pivot,
        this.channel});

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
    contentType = json['content_type'];
    createdAtHuman = json['created_at_human'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
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
    data['created_at_human'] = this.createdAtHuman;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? categoryId;
  int? videoId;

  Pivot({this.categoryId, this.videoId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    videoId = json['video_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['video_id'] = this.videoId;
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
  String? banner;

  Channel(
      {this.id,
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
        this.banner});

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
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['banner_image'] = this.bannerImage;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['region'] = this.region;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    return data;
  }
}
