class PlayVideoModel {
  String? status;
  String? message;
  Data? data;

  PlayVideoModel({this.status, this.message, this.data});

  PlayVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  int? like;
  int? comment;
  String? uploadSourceType;
  Channel? channel;
  String? status;
  String? visibility;
  int? duration;
  String? video;
  String? thumbnail;
  List<Categories>? categories;
  String? createdAtHuman;

  Data(
      {this.id,
        this.title,
        this.description,
        this.hashtag,
        this.like,
        this.comment,
        this.uploadSourceType,
        this.channel,
        this.status,
        this.visibility,
        this.duration,
        this.video,
        this.thumbnail,
        this.categories,
        this.createdAtHuman});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    like = json['like'];
    comment = json['comment'];
    uploadSourceType = json['upload_source_type'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    status = json['status'];
    visibility = json['visibility'];
    duration = json['duration'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['like'] = this.like;
    data['comment'] = this.comment;
    data['upload_source_type'] = this.uploadSourceType;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['duration'] = this.duration;
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at_human'] = this.createdAtHuman;
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? logo;
  Null? banner;

  Channel({this.id, this.name, this.logo, this.banner});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? parentId;
  String? description;
  String? image;
  String? type;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Categories(
      {this.id,
        this.name,
        this.parentId,
        this.description,
        this.image,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    image = json['image'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['type'] = this.type;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['category_id'] = this.categoryId;
    return data;
  }
}