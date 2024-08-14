class GetUserPlaylistModel {
  List<Playlist>? playlists;

  GetUserPlaylistModel({this.playlists});

  GetUserPlaylistModel.fromJson(Map<String, dynamic> json) {
    if (json['playlists'] != null) {
      playlists = <Playlist>[];
      json['playlists'].forEach((v) {
        playlists!.add(Playlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlist {
  int? id;
  String? title;
  String? description;
  int? userId;
  String? visibility;
  String? createdAt;
  String? updatedAt;
  String? createdAtHuman;
  List<dynamic>? videos;

  Playlist(
      {this.id,
        this.title,
        this.description,
        this.userId,
        this.visibility,
        this.createdAt,
        this.updatedAt,
        this.createdAtHuman,
        this.videos});

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    visibility = json['visibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdAtHuman = json['created_at_human'];
    if (json['videos'] != null) {
      videos = <dynamic>[];  // You can replace 'dynamic' with a specific type if you have a model for videos
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['user_id'] = userId;
    data['visibility'] = visibility;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_at_human'] = createdAtHuman;
    if (videos != null) {
      data['videos'] = videos;
    }
    return data;
  }
}
