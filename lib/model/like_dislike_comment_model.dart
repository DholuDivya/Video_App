class LikeDislikeCommentModel {
  bool? error;
  String? message;
  int? likesCount;
  bool? isLiked;
  bool? isDisliked;

  LikeDislikeCommentModel(
      {this.error,
        this.message,
        this.likesCount,
        this.isLiked,
        this.isDisliked});

  LikeDislikeCommentModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    likesCount = json['likes_count'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['likes_count'] = this.likesCount;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    return data;
  }
}
