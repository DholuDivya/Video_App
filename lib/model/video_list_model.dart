// class VideoListModel {
//   int? id;
//   String? name;
//   String? parentId;
//   String? description;
//   String? image;
//   String? type;
//   String? createdAt;
//   String? updatedAt;
//   List<Videos>? videos;
//
//   VideoListModel(
//       {this.id,
//         this.name,
//         this.parentId,
//         this.description,
//         this.image,
//         this.type,
//         this.createdAt,
//         this.updatedAt,
//         this.videos});
//
//   VideoListModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     parentId = json['parent_id'];
//     description = json['description'];
//     image = json['image'];
//     type = json['type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['videos'] != null) {
//       videos = <Videos>[];
//       json['videos'].forEach((v) {
//         videos!.add(new Videos.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['parent_id'] = this.parentId;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['type'] = this.type;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.videos != null) {
//       data['videos'] = this.videos!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Videos {
//   int? id;
//   String? type;
//   String? title;
//   String? slug;
//   String? description;
//   String? hashtag;
//   int? watchHours;
//   int? monetized;
//   String? geoRegion;
//   String? metaKeywords;
//   String? metaDescription;
//   String? source;
//   String? sourceType;
//   int? duration;
//   String? videoType;
//   String? thumbnails;
//   int? nSFW;
//   String? scheduling;
//   int? scheduled;
//   int? commentsOnOff;
//   int? channelId;
//   String? status;
//   String? deletedAt;
//   int? views;
//   int? likes;
//   String? visibility;
//   int? comments;
//   String? createdAt;
//   String? updatedAt;
//   String? createdAtHuman;
//   Pivot? pivot;
//   Channel? channel;
//
//   Videos(
//       {this.id,
//         this.type,
//         this.title,
//         this.slug,
//         this.description,
//         this.hashtag,
//         this.watchHours,
//         this.monetized,
//         this.geoRegion,
//         this.metaKeywords,
//         this.metaDescription,
//         this.source,
//         this.sourceType,
//         this.duration,
//         this.videoType,
//         this.thumbnails,
//         this.nSFW,
//         this.scheduling,
//         this.scheduled,
//         this.commentsOnOff,
//         this.channelId,
//         this.status,
//         this.deletedAt,
//         this.views,
//         this.likes,
//         this.visibility,
//         this.comments,
//         this.createdAt,
//         this.updatedAt,
//         this.createdAtHuman,
//         this.pivot,
//         this.channel});
//
//   Videos.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     title = json['title'];
//     slug = json['slug'];
//     description = json['description'];
//     hashtag = json['hashtag'];
//     watchHours = json['watch_hours'];
//     monetized = json['monetized'];
//     geoRegion = json['geo_region'];
//     metaKeywords = json['meta_keywords'];
//     metaDescription = json['meta_description'];
//     source = json['source'];
//     sourceType = json['source_type'];
//     duration = json['duration'];
//     videoType = json['video_type'];
//     thumbnails = json['thumbnails'];
//     nSFW = json['NSFW'];
//     scheduling = json['scheduling'];
//     scheduled = json['scheduled'];
//     commentsOnOff = json['comments_on_off'];
//     channelId = json['channel_id'];
//     status = json['status'];
//     deletedAt = json['deleted_at'];
//     views = json['views'];
//     likes = json['likes'];
//     visibility = json['visibility'];
//     comments = json['comments'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     createdAtHuman = json['created_at_human'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//     channel =
//     json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['title'] = this.title;
//     data['slug'] = this.slug;
//     data['description'] = this.description;
//     data['hashtag'] = this.hashtag;
//     data['watch_hours'] = this.watchHours;
//     data['monetized'] = this.monetized;
//     data['geo_region'] = this.geoRegion;
//     data['meta_keywords'] = this.metaKeywords;
//     data['meta_description'] = this.metaDescription;
//     data['source'] = this.source;
//     data['source_type'] = this.sourceType;
//     data['duration'] = this.duration;
//     data['video_type'] = this.videoType;
//     data['thumbnails'] = this.thumbnails;
//     data['NSFW'] = this.nSFW;
//     data['scheduling'] = this.scheduling;
//     data['scheduled'] = this.scheduled;
//     data['comments_on_off'] = this.commentsOnOff;
//     data['channel_id'] = this.channelId;
//     data['status'] = this.status;
//     data['deleted_at'] = this.deletedAt;
//     data['views'] = this.views;
//     data['likes'] = this.likes;
//     data['visibility'] = this.visibility;
//     data['comments'] = this.comments;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['created_at_human'] = this.createdAtHuman;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     if (this.channel != null) {
//       data['channel'] = this.channel!.toJson();
//     }
//     return data;
//   }
// }
//
// class Pivot {
//   int? categoryId;
//   int? videoId;
//
//   Pivot({this.categoryId, this.videoId});
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     videoId = json['video_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category_id'] = this.categoryId;
//     data['video_id'] = this.videoId;
//     return data;
//   }
// }
//
// class Channel {
//   int? id;
//   String? name;
//   String? slug;
//   String? description;
//   String? logo;
//   String? bannerImage;
//   String? status;
//   String? deletedAt;
//   String? region;
//   String? createdAt;
//   String? updatedAt;
//
//   Channel(
//       {this.id,
//         this.name,
//         this.slug,
//         this.description,
//         this.logo,
//         this.bannerImage,
//         this.status,
//         this.deletedAt,
//         this.region,
//         this.createdAt,
//         this.updatedAt});
//
//   Channel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     description = json['description'];
//     logo = json['logo'];
//     bannerImage = json['banner_image'];
//     status = json['status'];
//     deletedAt = json['deleted_at'];
//     region = json['region'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['description'] = this.description;
//     data['logo'] = this.logo;
//     data['banner_image'] = this.bannerImage;
//     data['status'] = this.status;
//     data['deleted_at'] = this.deletedAt;
//     data['region'] = this.region;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }










import 'package:meta/meta.dart';

class Category {
  final int id;
  final String name;
  final int? parentId;
  final String? description;
  final String? image;
  final String? type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Videos> videos;

  Category({
    required this.id,
    required this.name,
    this.parentId,
    this.description,
    this.image,
    this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      description: json['description'],
      image: json['image'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      videos: (json['videos'] as List).map((video) => Videos.fromJson(video)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'description': description,
      'image': image,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'videos': videos.map((video) => video.toJson()).toList(),
    };
  }
}

class Videos {
  final int id;
  final String type;
  final String title;
  final String slug;
  final String description;
  final String hashtag;
  final int watchHours;
  final int videoType;
  final String? geoRegion;
  final String? metaKeywords;
  final String? metaDescription;
  final String source;
  final String sourceType;
  final int duration;
  final String thumbnails;
  final int nsfw;
  final String? scheduling;
  final int scheduled;
  final int commentsOnOff;
  final int channelId;
  final String status;
  final String? deletedAt;
  final int views;
  final int likes;
  final String visibility;
  final int comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdAtHuman;
  final Pivot pivot;
  final Channel channel;

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
    required this.nsfw,
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
    required this.createdAtHuman,
    required this.pivot,
    required this.channel,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      id: json['id'],
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      hashtag: json['hashtag'] ?? '',
      watchHours: json['watch_hours'],
      videoType: json['video_type'],
      geoRegion: json['geo_region'],
      metaKeywords: json['meta_keywords'],
      metaDescription: json['meta_description'],
      source: json['source'],
      sourceType: json['source_type'] ?? '',
      duration: json['duration'] ?? '',
      thumbnails: json['thumbnails'] ?? '',
      nsfw: json['NSFW'],
      scheduling: json['scheduling'],
      scheduled: json['scheduled'],
      commentsOnOff: json['comments_on_off'],
      channelId: json['channel_id'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      views: json['views'] ?? '',
      likes: json['likes'] ,
      visibility: json['visibility'],
      comments: json['comments'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdAtHuman: json['created_at_human'] ?? '',
      pivot: Pivot.fromJson(json['pivot']),
      channel: Channel.fromJson(json['channel']),
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
      'NSFW': nsfw,
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_at_human': createdAtHuman,
      'pivot': pivot.toJson(),
      'channel': channel.toJson(),
    };
  }
}

class Pivot {
  final int categoryId;
  final int videoId;

  Pivot({
    required this.categoryId,
    required this.videoId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      categoryId: json['category_id'],
      videoId: json['video_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'video_id': videoId,
    };
  }
}

class Channel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String logo;
  final String? bannerImage;
  final String status;
  final String? deletedAt;
  final String? region;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? banner;

  Channel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.logo,
    this.bannerImage,
    required this.status,
    this.deletedAt,
    this.region,
    required this.createdAt,
    required this.updatedAt,
    this.banner,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      logo: json['logo'],
      bannerImage: json['banner_image'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      region: json['region'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      banner: json['banner'],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'banner': banner,
    };
  }
}
