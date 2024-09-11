














class GetChannelDetailModel {
  GetChannelDetailModel({
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

  final Channel channel;
  final String? createdAtHumanChannels;
  final bool isAssociated;
  final bool isSubscribed;
  final int videoCount;
  final int subscriberCount;
  final List<SuggestedVideos> suggestedVideos;
  final List<Playlists> playlists;
  final List<ChannelVideos> channelVideos;
  final List<ChannelShorts> channelShorts;

  factory GetChannelDetailModel.fromJson(Map<String, dynamic> json) {
    return GetChannelDetailModel(
      channel: Channel.fromJson(json['channel']),
      createdAtHumanChannels: json['created_at_human_channels'],
      isAssociated: json['is_associated'],
      isSubscribed: json['is_subscribed'],
      videoCount: json['video_count'],
      subscriberCount: json['subscriber_count'],
      suggestedVideos: (json['suggested_videos'] as List<dynamic>)
          .map((e) => SuggestedVideos.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlists: (json['playlists'] as List<dynamic>)
          .map((e) => Playlists.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelVideos: (json['channel_videos'] as List<dynamic>)
          .map((e) => ChannelVideos.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelShorts: (json['channel_shorts'] as List<dynamic>)
          .map((e) => ChannelShorts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channel': channel.toJson(),
      'created_at_human_channels': createdAtHumanChannels,
      'is_associated': isAssociated,
      'is_subscribed': isSubscribed,
      'video_count': videoCount,
      'subscriber_count': subscriberCount,
      'suggested_videos': suggestedVideos.map((e) => e.toJson()).toList(),
      'playlists': playlists.map((e) => e.toJson()).toList(),
      'channel_videos': channelVideos.map((e) => e.toJson()).toList(),
      'channel_shorts': channelShorts.map((e) => e.toJson()).toList(),
    };
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
    required this.deletedAt,
    required this.region,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });

  final int id;
  final String name;
  final String slug;
  final String description;
  final String logo;
  final String bannerImage;
  final String status;
  final String? deletedAt; // Nullable in case it can be null
  final String region;
  final String createdAt;
  final String updatedAt;
  final List<Videos> videos;

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      bannerImage: json['banner_image'] ?? '',
      status: json['status'] ?? '',
      deletedAt: json['deleted_at'], // Fixed key name
      region: json['region']  ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videos: (json['videos'] as List<dynamic>)
          .map((e) => Videos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'logo': logo,
      'banner_image': bannerImage,
      'status': status,
      'deleted_at': deletedAt,
      'region': region,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'videos': videos.map((e) => e.toJson()).toList(),
    };
  }
}




class Videos {
  Videos({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    this.hashtag,
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

  final int? id;
  final String type;
  final String title;
  final String slug;
  final String description;
  final String? hashtag; // Nullable if it can be null
  final String watchHours;
  final int? videoType;
  final String? geoRegion; // Nullable if it can be null
  final String? metaKeywords; // Nullable if it can be null
  final String? metaDescription; // Nullable if it can be null
  final String source;
  final String sourceType;
  final int? duration;
  final String thumbnails;
  final int? NSFW;
  final String? scheduling; // Nullable if it can be null
  final int? scheduled;
  final int? commentsOnOff;
  final int? channelId;
  final String status;
  final String? deletedAt; // Nullable if it can be null
  final int? views;
  final int? likes;
  final String visibility;
  final int? comments;
  final String createdAt;
  final String updatedAt;
  final String contentType;
  final String createdAtHuman;
  final List<Categories> categories;

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      hashtag: json['hashtag'],
      watchHours: json['watch_hours'],
      videoType: json['video_type'],
      geoRegion: json['geo_region'],
      metaKeywords: json['meta_keywords'],
      metaDescription: json['meta_description'],
      source: json['source'],
      sourceType: json['source_type'],
      duration: json['duration'],
      thumbnails: json['thumbnails'],
      NSFW: json['NSFW'],
      scheduling: json['scheduling'],
      scheduled: json['scheduled'],
      commentsOnOff: json['comments_on_off'],
      channelId: json['channel_id'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      views: json['views'],
      likes: json['likes'],
      visibility: json['visibility'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      contentType: json['content_type'],
      createdAtHuman: json['created_at_human'],
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'slug': slug,
      'description': description,
      'hashtag': hashtag,
      'watch_hours': watchHours,
      'video_type': videoType,
      'geo_region': geoRegion,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'source': source,
      'source_type': sourceType,
      'duration': duration,
      'thumbnails': thumbnails,
      'NSFW': NSFW,
      'scheduling': scheduling,
      'scheduled': scheduled,
      'comments_on_off': commentsOnOff,
      'channel_id': channelId,
      'status': status,
      'deleted_at': deletedAt,
      'views': views,
      'likes': likes,
      'visibility': visibility,
      'comments': comments,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'content_type': contentType,
      'created_at_human': createdAtHuman,
      'categories': categories.map((e) => e.toJson()).toList(),
    };
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

  final int id;
  final String name;
  final int? parentId; // Nullable
  final String? description; // Nullable
  final String? image; // Nullable
  final String createdAt;
  final String updatedAt;
  final int status;
  final Pivot pivot;

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'description': description,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
      'pivot': pivot.toJson(),
    };
  }
}


class Pivot {
  Pivot({
    required this.videoId,
    required this.categoryId,
  });

  final int videoId;
  final int categoryId;

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      videoId: json['video_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': videoId,
      'category_id': categoryId,
    };
  }
}


class SuggestedVideos {
  SuggestedVideos({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    this.hashtag,
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

  final int id;
  final String type;
  final String title;
  final String slug;
  final String description;
  final String? hashtag; // Nullable
  final String watchHours;
  final int videoType;
  final String? geoRegion; // Nullable
  final String? metaKeywords; // Nullable
  final String? metaDescription; // Nullable
  final String source;
  final String sourceType;
  final int duration;
  final String thumbnails;
  final int NSFW;
  final String? scheduling; // Nullable
  final int scheduled;
  final int commentsOnOff;
  final int channelId;
  final String status;
  final String? deletedAt; // Nullable
  final int views;
  final int likes;
  final String visibility;
  final int comments;
  final String createdAt;
  final String updatedAt;
  final String contentType;
  final String createdAtHuman;

  factory SuggestedVideos.fromJson(Map<String, dynamic> json) {
    return SuggestedVideos(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      hashtag: json['hashtag'],
      watchHours: json['watch_hours'],
      videoType: json['video_type'],
      geoRegion: json['geo_region'],
      metaKeywords: json['meta_keywords'],
      metaDescription: json['meta_description'],
      source: json['source'],
      sourceType: json['source_type'],
      duration: json['duration'],
      thumbnails: json['thumbnails'],
      NSFW: json['NSFW'],
      scheduling: json['scheduling'],
      scheduled: json['scheduled'],
      commentsOnOff: json['comments_on_off'],
      channelId: json['channel_id'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      views: json['views'],
      likes: json['likes'],
      visibility: json['visibility'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      contentType: json['content_type'],
      createdAtHuman: json['created_at_human'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'slug': slug,
      'description': description,
      'hashtag': hashtag,
      'watch_hours': watchHours,
      'video_type': videoType,
      'geo_region': geoRegion,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'source': source,
      'source_type': sourceType,
      'duration': duration,
      'thumbnails': thumbnails,
      'NSFW': NSFW,
      'scheduling': scheduling,
      'scheduled': scheduled,
      'comments_on_off': commentsOnOff,
      'channel_id': channelId,
      'status': status,
      'deleted_at': deletedAt,
      'views': views,
      'likes': likes,
      'visibility': visibility,
      'comments': comments,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'content_type': contentType,
      'created_at_human': createdAtHuman,
    };
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

  final int id;
  final String title;
  final String description;
  final int userId;
  final String visibility;
  final String createdAt;
  final String updatedAt;
  final List<Videos> videos;

  factory Playlists.fromJson(Map<String, dynamic> json) {
    return Playlists(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['user_id'],
      visibility: json['visibility'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      videos: (json['videos'] as List<dynamic>).map((e) => Videos.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'user_id': userId,
      'visibility': visibility,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'videos': videos.map((e) => e.toJson()).toList(),
    };
  }
}


class ChannelVideos {
  ChannelVideos({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    this.hashtag,
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

  final int id;
  final String type;
  final String title;
  final String slug;
  final String description;
  final String? hashtag; // Nullable
  final String watchHours;
  final int videoType;
  final String? geoRegion; // Nullable
  final String? metaKeywords; // Nullable
  final String? metaDescription; // Nullable
  final String source;
  final String sourceType;
  final int duration;
  final String thumbnails;
  final int NSFW;
  final String? scheduling; // Nullable
  final int scheduled;
  final int commentsOnOff;
  final int channelId;
  final String status;
  final String? deletedAt; // Nullable
  final int views;
  final int likes;
  final String visibility;
  final int comments;
  final String createdAt;
  final String updatedAt;
  final String contentType;
  final String createdAtHuman;
  final List<Categories> categories;

  factory ChannelVideos.fromJson(Map<String, dynamic> json) {
    return ChannelVideos(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      hashtag: json['hashtag'],
      watchHours: json['watch_hours'],
      videoType: json['video_type'],
      geoRegion: json['geo_region'],
      metaKeywords: json['meta_keywords'],
      metaDescription: json['meta_description'],
      source: json['source'],
      sourceType: json['source_type'],
      duration: json['duration'],
      thumbnails: json['thumbnails'],
      NSFW: json['NSFW'],
      scheduling: json['scheduling'],
      scheduled: json['scheduled'],
      commentsOnOff: json['comments_on_off'],
      channelId: json['channel_id'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      views: json['views'],
      likes: json['likes'],
      visibility: json['visibility'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      contentType: json['content_type'],
      createdAtHuman: json['created_at_human'],
      categories: (json['categories'] as List<dynamic>).map((e) => Categories.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'slug': slug,
      'description': description,
      'hashtag': hashtag,
      'watch_hours': watchHours,
      'video_type': videoType,
      'geo_region': geoRegion,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'source': source,
      'source_type': sourceType,
      'duration': duration,
      'thumbnails': thumbnails,
      'NSFW': NSFW,
      'scheduling': scheduling,
      'scheduled': scheduled,
      'comments_on_off': commentsOnOff,
      'channel_id': channelId,
      'status': status,
      'deleted_at': deletedAt,
      'views': views,
      'likes': likes,
      'visibility': visibility,
      'comments': comments,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'content_type': contentType,
      'created_at_human': createdAtHuman,
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}


class ChannelShorts {
  ChannelShorts({
    required this.id,
    required this.type,
    required this.title,
    required this.slug,
    required this.description,
    this.hashtag,
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

  final int id;
  final String type;
  final String title;
  final String slug;
  final String description;
  final String? hashtag; // Nullable
  final String watchHours;
  final int videoType;
  final String? geoRegion; // Nullable
  final String? metaKeywords; // Nullable
  final String? metaDescription; // Nullable
  final String source;
  final String sourceType;
  final int duration;
  final String thumbnails;
  final int NSFW;
  final String? scheduling; // Nullable
  final int scheduled;
  final int commentsOnOff;
  final int channelId;
  final String status;
  final String? deletedAt; // Nullable
  final int views;
  final int likes;
  final String visibility;
  final int comments;
  final String createdAt;
  final String updatedAt;
  final String contentType;
  final String createdAtHuman;
  final List<Categories> categories;

  factory ChannelShorts.fromJson(Map<String, dynamic> json) {
    return ChannelShorts(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      hashtag: json['hashtag'],
      watchHours: json['watch_hours'],
      videoType: json['video_type'],
      geoRegion: json['geo_region'],
      metaKeywords: json['meta_keywords'],
      metaDescription: json['meta_description'],
      source: json['source'],
      sourceType: json['source_type'],
      duration: json['duration'],
      thumbnails: json['thumbnails'],
      NSFW: json['NSFW'],
      scheduling: json['scheduling'],
      scheduled: json['scheduled'],
      commentsOnOff: json['comments_on_off'],
      channelId: json['channel_id'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      views: json['views'],
      likes: json['likes'],
      visibility: json['visibility'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      contentType: json['content_type'],
      createdAtHuman: json['created_at_human'],
      categories: (json['categories'] as List<dynamic>).map((e) => Categories.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'slug': slug,
      'description': description,
      'hashtag': hashtag,
      'watch_hours': watchHours,
      'video_type': videoType,
      'geo_region': geoRegion,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'source': source,
      'source_type': sourceType,
      'duration': duration,
      'thumbnails': thumbnails,
      'NSFW': NSFW,
      'scheduling': scheduling,
      'scheduled': scheduled,
      'comments_on_off': commentsOnOff,
      'channel_id': channelId,
      'status': status,
      'deleted_at': deletedAt,
      'views': views,
      'likes': likes,
      'visibility': visibility,
      'comments': comments,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'content_type': contentType,
      'created_at_human': createdAtHuman,
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}
