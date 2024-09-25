class GetUserPlaylistModel {
  bool? error;
  String? message;
  List<PlaylistList>? playlists;

  GetUserPlaylistModel({this.error, this.message, this.playlists});

  GetUserPlaylistModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['playlists'] != null) {
      playlists = <PlaylistList>[];
      json['playlists'].forEach((v) {
        playlists!.add(new PlaylistList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.playlists != null) {
      data['playlists'] = this.playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaylistList {
  int? id;
  String? title;
  String? description;
  int? userId;
  String? visibility;
  String? createdAt;
  String? updatedAt;
  List<Videos>? videos;

  PlaylistList(
      {this.id,
        this.title,
        this.description,
        this.userId,
        this.visibility,
        this.createdAt,
        this.updatedAt,
        this.videos});

  PlaylistList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    visibility = json['visibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['visibility'] = this.visibility;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? id;
  String? slug;
  String? title;
  String? source;
  String? thumbnails;
  String? sourceType;
  String? createdAt;
  Pivot? pivot;
  List<Categories>? categories;

  Videos(
      {this.id,
        this.slug,
        this.title,
        this.source,
        this.thumbnails,
        this.sourceType,
        this.createdAt,
        this.pivot,
        this.categories});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    source = json['source'];
    thumbnails = json['thumbnails'];
    sourceType = json['source_type'];
    createdAt = json['created_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['source'] = this.source;
    data['thumbnails'] = this.thumbnails;
    data['source_type'] = this.sourceType;
    data['created_at'] = this.createdAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? playlistId;
  int? videosId;

  Pivot({this.playlistId, this.videosId});

  Pivot.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    videosId = json['videos_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlist_id'] = this.playlistId;
    data['videos_id'] = this.videosId;
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
