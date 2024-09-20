class GetShortsBySlugModel {
  String? status;
  String? message;
  List<Data>? data;

  GetShortsBySlugModel({this.status, this.message, this.data});

  GetShortsBySlugModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  int? dislikes;
  int? comments;
  int? views;
  String? uploadSourceType;
  Channel? channel;
  String? status;
  String? visibility;
  int? duration;
  String? thumbnail;
  List<Categories>? categories;
  String? createdAtHuman;
  String? sources;
  bool? isLiked;
  bool? isDisliked;

  Data(
      {this.id,
        this.title,
        this.description,
        this.hashtag,
        this.likes,
        this.dislikes,
        this.comments,
        this.views,
        this.uploadSourceType,
        this.channel,
        this.status,
        this.visibility,
        this.duration,
        this.thumbnail,
        this.categories,
        this.createdAtHuman,
        this.sources,
        this.isLiked,
        this.isDisliked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    comments = json['comments'];
    views = json['views'];
    uploadSourceType = json['upload_source_type'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    status = json['status'];
    visibility = json['visibility'];
    duration = json['duration'];
    thumbnail = json['thumbnail'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    createdAtHuman = json['created_at_human'];
    sources = json['sources'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['comments'] = this.comments;
    data['views'] = this.views;
    data['upload_source_type'] = this.uploadSourceType;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at_human'] = this.createdAtHuman;
    data['sources'] = this.sources;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? logo;
  Null? banner;
  int? subscriberCount;
  bool? isSubscribed;
  bool? isAssociated;

  Channel(
      {this.id,
        this.name,
        this.logo,
        this.banner,
        this.subscriberCount,
        this.isSubscribed,
        this.isAssociated});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  Null? parentId;
  Null? description;
  Null? image;
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
