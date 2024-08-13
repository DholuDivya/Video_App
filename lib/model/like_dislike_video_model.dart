class LikeDislikeVideoModel {
  bool? error;
  String? message;
  Data? data;

  LikeDislikeVideoModel({this.error, this.message, this.data});

  LikeDislikeVideoModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? likesCount;
  int? dislikesCount;
  bool? isLiked;
  bool? isDisliked;

  Data({this.likesCount, this.dislikesCount, this.isLiked, this.isDisliked});

  Data.fromJson(Map<String, dynamic> json) {
    likesCount = json['likes_count'];
    dislikesCount = json['dislikes_count'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes_count'] = this.likesCount;
    data['dislikes_count'] = this.dislikesCount;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    return data;
  }
}
