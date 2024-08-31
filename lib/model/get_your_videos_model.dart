class GetYourVideosModel {
  GetYourVideosModel({
    required this.channel,
    required this.createdAtHumanChannels,
    required this.isAssociated,
    required this.isSubscribed,
    required this.videoCount,
    required this.subscriberCount,
    required this.suggestedVideos,
    required this.playlists,
    required this.channelVideos,
    required this.channelShorts,
  });
  late final Channel channel;
  late final String createdAtHumanChannels;
  late final bool isAssociated;
  late final bool isSubscribed;
  late final int videoCount;
  late final int subscriberCount;
  late final List<SuggestedVideos> suggestedVideos;
  late final List<Playlists> playlists;
  late final List<ChannelVideos> channelVideos;
  late final List<ChannelShorts> channelShorts;

  GetYourVideosModel.fromJson(Map<String, dynamic> json){
    channel = Channel.fromJson(json['channel']);
    createdAtHumanChannels = json['created_at_human_channels'];
    isAssociated = json['is_associated'];
    isSubscribed = json['is_subscribed'];
    videoCount = json['video_count'];
    subscriberCount = json['subscriber_count'];
    suggestedVideos = List.from(json['suggested_videos']).map((e)=>SuggestedVideos.fromJson(e)).toList();
    playlists = List.from(json['playlists']).map((e)=>Playlists.fromJson(e)).toList();
    channelVideos = List.from(json['channel_videos']).map((e)=>ChannelVideos.fromJson(e)).toList();
    channelShorts = List.from(json['channel_shorts']).map((e)=>ChannelShorts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['channel'] = channel.toJson();
    _data['created_at_human_channels'] = createdAtHumanChannels;
    _data['is_associated'] = isAssociated;
    _data['is_subscribed'] = isSubscribed;
    _data['video_count'] = videoCount;
    _data['subscriber_count'] = subscriberCount;
    _data['suggested_videos'] = suggestedVideos.map((e)=>e.toJson()).toList();
    _data['playlists'] = playlists.map((e)=>e.toJson()).toList();
    _data['channel_videos'] = channelVideos.map((e)=>e.toJson()).toList();
    _data['channel_shorts'] = channelShorts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Channel {
  Channel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.logo,
    required this.bannerImage,
    required this.status,
    this.deletedAt,
    this.region,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });
  late final int id;
  late final String name;
  late final String slug;
  late final String description;
  late final String logo;
  late final String bannerImage;
  late final String status;
  late final Null deletedAt;
  late final Null region;
  late final String createdAt;
  late final String updatedAt;
  late final List<Videos> videos;

  Channel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    logo = json['logo'];
    bannerImage = json['banner_image'];
    status = json['status'];
    deletedAt = null;
    region = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    videos = List.from(json['videos']).map((e)=>Videos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['logo'] = logo;
    _data['banner_image'] = bannerImage;
    _data['status'] = status;
    _data['deleted_at'] = deletedAt;
    _data['region'] = region;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['videos'] = videos.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Videos {
  Videos({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    required this.hashtag,
    required this.watchHours,
    required this.videoType,
    this.geoRegion,
    this.metaKeywords,
    this.metaDescription,
    required this.source,
    required this.sourceType,
    required this.duration,
    required this.thumbnails,
    required this.NSFW,
    this.scheduling,
    required this.scheduled,
    required this.commentsOnOff,
    required this.channelId,
    required this.status,
    this.deletedAt,
    required this.views,
    required this.likes,
    required this.visibility,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.contentType,
    required this.createdAtHuman,
    required this.categories,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String slug;
  late final String description;
  late final String hashtag;
  late final String watchHours;
  late final int videoType;
  late final Null geoRegion;
  late final Null metaKeywords;
  late final Null metaDescription;
  late final String source;
  late final String sourceType;
  late final int duration;
  late final String thumbnails;
  late final int NSFW;
  late final Null scheduling;
  late final int scheduled;
  late final int commentsOnOff;
  late final int channelId;
  late final String status;
  late final Null deletedAt;
  late final int views;
  late final int likes;
  late final String visibility;
  late final int comments;
  late final String createdAt;
  late final String updatedAt;
  late final String contentType;
  late final String createdAtHuman;
  late final List<Categories> categories;

  Videos.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    hashtag = json['hashtag'];
    watchHours = json['watch_hours'];
    videoType = json['video_type'];
    geoRegion = null;
    metaKeywords = null;
    metaDescription = null;
    source = json['source'];
    sourceType = json['source_type'];
    duration = json['duration'];
    thumbnails = json['thumbnails'];
    NSFW = json['NSFW'];
    scheduling = null;
    scheduled = json['scheduled'];
    commentsOnOff = json['comments_on_off'];
    channelId = json['channel_id'];
    status = json['status'];
    deletedAt = null;
    views = json['views'];
    likes = json['likes'];
    visibility = json['visibility'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentType = json['content_type'];
    createdAtHuman = json['created_at_human'];
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['hashtag'] = hashtag;
    _data['watch_hours'] = watchHours;
    _data['video_type'] = videoType;
    _data['geo_region'] = geoRegion;
    _data['meta_keywords'] = metaKeywords;
    _data['meta_description'] = metaDescription;
    _data['source'] = source;
    _data['source_type'] = sourceType;
    _data['duration'] = duration;
    _data['thumbnails'] = thumbnails;
    _data['NSFW'] = NSFW;
    _data['scheduling'] = scheduling;
    _data['scheduled'] = scheduled;
    _data['comments_on_off'] = commentsOnOff;
    _data['channel_id'] = channelId;
    _data['status'] = status;
    _data['deleted_at'] = deletedAt;
    _data['views'] = views;
    _data['likes'] = likes;
    _data['visibility'] = visibility;
    _data['comments'] = comments;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['content_type'] = contentType;
    _data['created_at_human'] = createdAtHuman;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    this.parentId,
    this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.pivot,
  });
  late final int id;
  late final String name;
  late final Null parentId;
  late final Null description;
  late final Null image;
  late final String createdAt;
  late final String updatedAt;
  late final int status;
  late final Pivot pivot;

  Categories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    parentId = null;
    description = null;
    image = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    pivot = Pivot.fromJson(json['pivot']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['parent_id'] = parentId;
    _data['description'] = description;
    _data['image'] = image;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['status'] = status;
    _data['pivot'] = pivot.toJson();
    return _data;
  }
}

class Pivot {
  Pivot({
    required this.videoId,
    required this.categoryId,
  });
  late final int videoId;
  late final int categoryId;

  Pivot.fromJson(Map<String, dynamic> json){
    videoId = json['video_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['video_id'] = videoId;
    _data['category_id'] = categoryId;
    return _data;
  }
}

class SuggestedVideos {
  SuggestedVideos({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    required this.hashtag,
    required this.watchHours,
    required this.videoType,
    this.geoRegion,
    this.metaKeywords,
    this.metaDescription,
    required this.source,
    required this.sourceType,
    required this.duration,
    required this.thumbnails,
    required this.NSFW,
    this.scheduling,
    required this.scheduled,
    required this.commentsOnOff,
    required this.channelId,
    required this.status,
    this.deletedAt,
    required this.views,
    required this.likes,
    required this.visibility,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.contentType,
    required this.createdAtHuman,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String slug;
  late final String description;
  late final String hashtag;
  late final String watchHours;
  late final int videoType;
  late final Null geoRegion;
  late final Null metaKeywords;
  late final Null metaDescription;
  late final String source;
  late final String sourceType;
  late final int duration;
  late final String thumbnails;
  late final int NSFW;
  late final Null scheduling;
  late final int scheduled;
  late final int commentsOnOff;
  late final int channelId;
  late final String status;
  late final Null deletedAt;
  late final int views;
  late final int likes;
  late final String visibility;
  late final int comments;
  late final String createdAt;
  late final String updatedAt;
  late final String contentType;
  late final String createdAtHuman;

  SuggestedVideos.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    hashtag = json['hashtag'];
    watchHours = json['watch_hours'];
    videoType = json['video_type'];
    geoRegion = null;
    metaKeywords = null;
    metaDescription = null;
    source = json['source'];
    sourceType = json['source_type'];
    duration = json['duration'];
    thumbnails = json['thumbnails'];
    NSFW = json['NSFW'];
    scheduling = null;
    scheduled = json['scheduled'];
    commentsOnOff = json['comments_on_off'];
    channelId = json['channel_id'];
    status = json['status'];
    deletedAt = null;
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['hashtag'] = hashtag;
    _data['watch_hours'] = watchHours;
    _data['video_type'] = videoType;
    _data['geo_region'] = geoRegion;
    _data['meta_keywords'] = metaKeywords;
    _data['meta_description'] = metaDescription;
    _data['source'] = source;
    _data['source_type'] = sourceType;
    _data['duration'] = duration;
    _data['thumbnails'] = thumbnails;
    _data['NSFW'] = NSFW;
    _data['scheduling'] = scheduling;
    _data['scheduled'] = scheduled;
    _data['comments_on_off'] = commentsOnOff;
    _data['channel_id'] = channelId;
    _data['status'] = status;
    _data['deleted_at'] = deletedAt;
    _data['views'] = views;
    _data['likes'] = likes;
    _data['visibility'] = visibility;
    _data['comments'] = comments;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['content_type'] = contentType;
    _data['created_at_human'] = createdAtHuman;
    return _data;
  }
}

class Playlists {
  Playlists({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });
  late final int id;
  late final String title;
  late final String description;
  late final int userId;
  late final String visibility;
  late final String createdAt;
  late final String updatedAt;
  late final List<dynamic> videos;

  Playlists.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    visibility = json['visibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    videos = List.castFrom<dynamic, dynamic>(json['videos']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['user_id'] = userId;
    _data['visibility'] = visibility;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['videos'] = videos;
    return _data;
  }
}

class ChannelVideos {
  ChannelVideos({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    required this.hashtag,
    required this.watchHours,
    required this.videoType,
    this.geoRegion,
    this.metaKeywords,
    this.metaDescription,
    required this.source,
    required this.sourceType,
    required this.duration,
    required this.thumbnails,
    required this.NSFW,
    this.scheduling,
    required this.scheduled,
    required this.commentsOnOff,
    required this.channelId,
    required this.status,
    this.deletedAt,
    required this.views,
    required this.likes,
    required this.visibility,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.contentType,
    required this.createdAtHuman,
    required this.categories,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String slug;
  late final String description;
  late final String hashtag;
  late final String watchHours;
  late final int videoType;
  late final Null geoRegion;
  late final Null metaKeywords;
  late final Null metaDescription;
  late final String source;
  late final String sourceType;
  late final int duration;
  late final String thumbnails;
  late final int NSFW;
  late final Null scheduling;
  late final int scheduled;
  late final int commentsOnOff;
  late final int channelId;
  late final String status;
  late final Null deletedAt;
  late final int views;
  late final int likes;
  late final String visibility;
  late final int comments;
  late final String createdAt;
  late final String updatedAt;
  late final String contentType;
  late final String createdAtHuman;
  late final List<Categories> categories;

  ChannelVideos.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    hashtag = json['hashtag'];
    watchHours = json['watch_hours'];
    videoType = json['video_type'];
    geoRegion = null;
    metaKeywords = null;
    metaDescription = null;
    source = json['source'];
    sourceType = json['source_type'];
    duration = json['duration'];
    thumbnails = json['thumbnails'];
    NSFW = json['NSFW'];
    scheduling = null;
    scheduled = json['scheduled'];
    commentsOnOff = json['comments_on_off'];
    channelId = json['channel_id'];
    status = json['status'];
    deletedAt = null;
    views = json['views'];
    likes = json['likes'];
    visibility = json['visibility'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentType = json['content_type'];
    createdAtHuman = json['created_at_human'];
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['hashtag'] = hashtag;
    _data['watch_hours'] = watchHours;
    _data['video_type'] = videoType;
    _data['geo_region'] = geoRegion;
    _data['meta_keywords'] = metaKeywords;
    _data['meta_description'] = metaDescription;
    _data['source'] = source;
    _data['source_type'] = sourceType;
    _data['duration'] = duration;
    _data['thumbnails'] = thumbnails;
    _data['NSFW'] = NSFW;
    _data['scheduling'] = scheduling;
    _data['scheduled'] = scheduled;
    _data['comments_on_off'] = commentsOnOff;
    _data['channel_id'] = channelId;
    _data['status'] = status;
    _data['deleted_at'] = deletedAt;
    _data['views'] = views;
    _data['likes'] = likes;
    _data['visibility'] = visibility;
    _data['comments'] = comments;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['content_type'] = contentType;
    _data['created_at_human'] = createdAtHuman;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ChannelShorts {
  ChannelShorts({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    required this.hashtag,
    required this.watchHours,
    required this.videoType,
    this.geoRegion,
    this.metaKeywords,
    this.metaDescription,
    required this.source,
    required this.sourceType,
    required this.duration,
    required this.thumbnails,
    required this.NSFW,
    this.scheduling,
    required this.scheduled,
    required this.commentsOnOff,
    required this.channelId,
    required this.status,
    this.deletedAt,
    required this.views,
    required this.likes,
    required this.visibility,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.contentType,
    required this.createdAtHuman,
    required this.categories,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String slug;
  late final String description;
  late final String hashtag;
  late final String watchHours;
  late final int videoType;
  late final Null geoRegion;
  late final Null metaKeywords;
  late final Null metaDescription;
  late final String source;
  late final String sourceType;
  late final int duration;
  late final String thumbnails;
  late final int NSFW;
  late final Null scheduling;
  late final int scheduled;
  late final int commentsOnOff;
  late final int channelId;
  late final String status;
  late final Null deletedAt;
  late final int views;
  late final int likes;
  late final String visibility;
  late final int comments;
  late final String createdAt;
  late final String updatedAt;
  late final String contentType;
  late final String createdAtHuman;
  late final List<Categories> categories;

  ChannelShorts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    hashtag = json['hashtag'];
    watchHours = json['watch_hours'];
    videoType = json['video_type'];
    geoRegion = null;
    metaKeywords = null;
    metaDescription = null;
    source = json['source'];
    sourceType = json['source_type'];
    duration = json['duration'];
    thumbnails = json['thumbnails'];
    NSFW = json['NSFW'];
    scheduling = null;
    scheduled = json['scheduled'];
    commentsOnOff = json['comments_on_off'];
    channelId = json['channel_id'];
    status = json['status'];
    deletedAt = null;
    views = json['views'];
    likes = json['likes'];
    visibility = json['visibility'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentType = json['content_type'];
    createdAtHuman = json['created_at_human'];
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['hashtag'] = hashtag;
    _data['watch_hours'] = watchHours;
    _data['video_type'] = videoType;
    _data['geo_region'] = geoRegion;
    _data['meta_keywords'] = metaKeywords;
    _data['meta_description'] = metaDescription;
    _data['source'] = source;
    _data['source_type'] = sourceType;
    _data['duration'] = duration;
    _data['thumbnails'] = thumbnails;
    _data['NSFW'] = NSFW;
    _data['scheduling'] = scheduling;
    _data['scheduled'] = scheduled;
    _data['comments_on_off'] = commentsOnOff;
    _data['channel_id'] = channelId;
    _data['status'] = status;
    _data['deleted_at'] = deletedAt;
    _data['views'] = views;
    _data['likes'] = likes;
    _data['visibility'] = visibility;
    _data['comments'] = comments;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['content_type'] = contentType;
    _data['created_at_human'] = createdAtHuman;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    return _data;
  }
}