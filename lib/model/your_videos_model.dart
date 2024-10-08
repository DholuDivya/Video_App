class YourVideosModel {
  String? error;
  String? message;
  List<YourVideosData>? data;

  YourVideosModel({this.error, this.message, this.data});

  YourVideosModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <YourVideosData>[];
      json['data'].forEach((v) {
        data!.add(new YourVideosData.fromJson(v));
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

class YourVideosData {
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

  YourVideosData(
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
        this.slug});

  YourVideosData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
