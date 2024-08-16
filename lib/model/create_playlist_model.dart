class CreatePlaylistModel {
  String? message;
  Playlist? playlist;

  CreatePlaylistModel({this.message, this.playlist});

  CreatePlaylistModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    playlist = json['playlist'] != null
        ? new Playlist.fromJson(json['playlist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.playlist != null) {
      data['playlist'] = this.playlist!.toJson();
    }
    return data;
  }
}

class Playlist {
  String? title;
  String? description;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Playlist(
      {this.title,
        this.description,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Playlist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
