class YourShortsModel {
  String? error;
  String? message;
  List<YourShortsData>? data;

  YourShortsModel({this.error, this.message, this.data});

  YourShortsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <YourShortsData>[];
      json['data'].forEach((v) {
        data!.add(new YourShortsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YourShortsData {
  int? id;
  String? title;
  String? description;
  String? source;
  int? duration;
  String? thumbnail;
  String? createdAtHuman;
  String? status;
  String? visibility;
  int? views;
  int? likes;
  String? type;
  String? slug;
  Channel? channel;

  YourShortsData(
      {this.id,
        this.title,
        this.description,
        this.source,
        this.duration,
        this.thumbnail,
        this.createdAtHuman,
        this.status,
        this.visibility,
        this.views,
        this.likes,
        this.type,
        this.slug,
        this.channel});

  YourShortsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    source = json['source'];
    duration = json['duration'];
    thumbnail = json['thumbnail'];
    createdAtHuman = json['created_at_human'];
    status = json['status'];
    visibility = json['visibility'];
    views = json['views'];
    likes = json['likes'];
    type = json['type'];
    slug = json['slug'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['source'] = this.source;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    data['created_at_human'] = this.createdAtHuman;
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['type'] = this.type;
    data['slug'] = this.slug;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? logo;
  String? banner;
  int? subscriberCount;

  Channel({this.id, this.name, this.logo, this.banner, this.subscriberCount});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
    subscriberCount = json['subscriber_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['subscriber_count'] = this.subscriberCount;
    return data;
  }
}
