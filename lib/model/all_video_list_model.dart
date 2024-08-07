class AllVideoListModel {
  String? status;
  String? message;
  Data? data;

  AllVideoListModel({this.status, this.message, this.data});

  factory AllVideoListModel.fromJson(Map<String, dynamic> json) {
    return AllVideoListModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<VideoData>? videos;  // Changed variable name to match JSON response
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.videos,  // Changed variable name to match JSON response
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      videos: json['videos'] != null  // Changed key to match JSON response
          ? (json['videos'] as List).map((i) => VideoData.fromJson(i)).toList()
          : null,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] != null
          ? (json['links'] as List).map((i) => Links.fromJson(i)).toList()
          : null,
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_page'] = this.currentPage;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();  // Changed key to match JSON response
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class VideoData {
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
  String? video;
  String? thumbnail;
  List<Categories>? categories;
  String? createdAtHuman;

  VideoData({
    this.id,
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
    this.video,
    this.thumbnail,
    this.categories,
    this.createdAtHuman,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      description: json['description'],
      hashtag: json['hashtag'],
      views: json['views'],
      likes: json['likes'],
      type: json['type'],
      channel: json['channel'] != null ? Channel.fromJson(json['channel']) : null,
      status: json['status'],
      visibility: json['visibility'],
      duration: json['duration'],
      video: json['video'],
      thumbnail: json['thumbnail'],
      categories: json['categories'] != null
          ? (json['categories'] as List).map((i) => Categories.fromJson(i)).toList()
          : null,
      createdAtHuman: json['created_at_human'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  String? banner;

  Channel({this.id, this.name, this.logo, this.banner});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      banner: json['banner'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  int? parentId;  // Changed type from String to int
  String? description;
  String? image;
  String? type;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Categories({
    this.id,
    this.name,
    this.parentId,  // Changed type from String to int
    this.description,
    this.image,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],  // Changed type from String to int
      description: json['description'],
      image: json['image'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;  // Changed type from String to int
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

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      videoId: json['video_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['video_id'] = this.videoId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
