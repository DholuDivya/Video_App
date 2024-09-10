import 'package:flutter/physics.dart';

class PlayVideoModel {
  String? status;
  String? message;
  Data? data;

  PlayVideoModel({this.status, this.message, this.data});

  PlayVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? hashtag;
  int? likes;
  int? dislikes; // New field for dislikes
  int? comments;
  int? views;
  String? uploadSourceType;
  Channel? channel;
  String? status;
  String? visibility;
  int? duration;
  String? video;
  String? thumbnail;
  bool? isLiked;
  bool? isDisliked;
  List<Categories>? categories;
  String? createdAtHuman;
  List<Recommended>? recommended;

  Data({
    this.id,
    this.title,
    this.description,
    this.hashtag,
    this.likes,
    this.dislikes, // Initialize dislikes
    this.comments,
    this.views,
    this.uploadSourceType,
    this.channel,
    this.status,
    this.visibility,
    this.duration,
    this.video,
    this.thumbnail,
    this.isLiked,
    this.isDisliked,
    this.categories,
    this.createdAtHuman,
    this.recommended,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    likes = json['likes'];
    dislikes = json['dislikes']; // Parsing dislikes
    comments = json['comments'];
    views = json['views'];
    uploadSourceType = json['upload_source_type'];
    channel = json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    status = json['status'];
    visibility = json['visibility'];
    duration = json['duration'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    createdAtHuman = json['created_at_human'];
    if (json['recommended'] != null) {
      recommended = <Recommended>[];
      json['recommended'].forEach((v) {
        recommended!.add(Recommended.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes; // Serialize dislikes
    data['comments'] = this.comments;
    data['views'] = this.views;
    data['upload_source_type'] = this.uploadSourceType;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['duration'] = this.duration;
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at_human'] = this.createdAtHuman;
    if (this.recommended != null) {
      data['recommended'] = this.recommended!.map((v) => v.toJson()).toList();
    }
    // print('tytytytytytytytytyt   ${Data.fromJson()}');
    return data;
  }

}

class Channel {
  int? id;
  String? name;
  String? logo;
  String? banner;
  int? subscriberCount;
  bool? isSubscribed;
  bool? isAssociated; // Ensure this field is included

  Channel({
    this.id,
    this.name,
    this.logo,
    this.banner,
    this.subscriberCount,
    this.isSubscribed,
    this.isAssociated,
  });

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
    subscriberCount = json['subscriber_count'];
    isSubscribed = json['is_subscribed'];
    isAssociated = json['is_associated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['subscriber_count'] = this.subscriberCount;
    data['is_subscribed'] = this.isSubscribed;
    data['is_associated'] = this.isAssociated;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? parentId;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Categories({
    this.id,
    this.name,
    this.parentId,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_id'] = this.videoId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Recommended {
  int? id;
  String? slug;
  String? title;
  String? description;
  String? hashtag;
  int? views;
  int? likes;
  int? dislikes; // Add dislikes for recommended videos
  String? type;
  Channel? channel;
  String? status;
  String? visibility;
  int? duration;
  String? video;
  String? thumbnail;
  bool? isLiked;
  bool? isDisliked;
  List<Categories>? categories;
  String? createdAtHuman;

  Recommended({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.hashtag,
    this.views,
    this.likes,
    this.dislikes, // Initialize dislikes
    this.type,
    this.channel,
    this.status,
    this.visibility,
    this.duration,
    this.video,
    this.thumbnail,
    this.isLiked,
    this.isDisliked,
    this.categories,
    this.createdAtHuman,
  });

  Recommended.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    views = json['views'];
    likes = json['likes'];
    dislikes = json['dislikes']; // Parse dislikes
    type = json['type'];
    channel = json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    status = json['status'];
    visibility = json['visibility'];
    duration = json['duration'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes; // Serialize dislikes
    data['type'] = this.type;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['duration'] = this.duration;
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at_human'] = this.createdAtHuman;
    return data;
  }
}
