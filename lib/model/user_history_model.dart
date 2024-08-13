class UserHistoryModel {
  bool? error;
  String? message;
  List<Data>? data;
  List<String>? watchedDuration;

  UserHistoryModel({this.error, this.message, this.data, this.watchedDuration});

  UserHistoryModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    watchedDuration = json['watched_duration'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['watched_duration'] = this.watchedDuration;
    return data;
  }
}

class Data {
  int? id;
  String? slug;
  String? title;
  String? description;
  String? hashtag;
  int? views;
  int? likes;
  String? type;
  Channel? channel;
  String? status;
  String? visibility;
  int? duration;
  String? videoUrl;
  String? thumbnail;
  List<Categories>? categories;
  String? createdAtHuman;

  Data(
      {this.id,
        this.slug,
        this.title,
        this.description,
        this.hashtag,
        this.views,
        this.likes,
        this.type,
        this.channel,
        this.status,
        this.visibility,
        this.duration,
        this.videoUrl,
        this.thumbnail,
        this.categories,
        this.createdAtHuman});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    views = json['views'];
    likes = json['likes'];
    type = json['type'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    status = json['status'];
    visibility = json['visibility'];
    duration = json['duration'];
    videoUrl = json['video_url'];
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
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['type'] = this.type;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['duration'] = this.duration;
    data['video_url'] = this.videoUrl;
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
  String? banner;

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

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
