class GetCommentsModel {
  bool? error;
  String? message;
  List<Data>? data;

  GetCommentsModel({this.error, this.message, this.data});

  GetCommentsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? videosId;
  int? userId;
  String? comment;
  String? status;
  int? pinned;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  bool? isLiked;
  bool? isDisliked;
  String? createdAtHuman;
  User? user;

  Data(
      {this.id,
        this.videosId,
        this.userId,
        this.comment,
        this.status,
        this.pinned,
        this.createdAt,
        this.updatedAt,
        this.likesCount,
        this.isLiked,
        this.isDisliked,
        this.createdAtHuman,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videosId = json['videos_id'];
    userId = json['user_id'];
    comment = json['comment'];
    status = json['status'];
    pinned = json['pinned'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
    createdAtHuman = json['created_at_human'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['videos_id'] = this.videosId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['pinned'] = this.pinned;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    data['created_at_human'] = this.createdAtHuman;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  int? status;
  String? phoneNumber;
  String? emailVerifiedAt;
  String? profile;
  String? type;
  String? fcmId;
  int? notification;
  String? firebaseId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? countryCode;
  String? firebaseUid;

  User(
      {this.id,
        this.name,
        this.email,
        this.status,
        this.phoneNumber,
        this.emailVerifiedAt,
        this.profile,
        this.type,
        this.fcmId,
        this.notification,
        this.firebaseId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.countryCode,
        this.firebaseUid});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    profile = json['profile'];
    type = json['type'];
    fcmId = json['fcm_id'];
    notification = json['notification'];
    firebaseId = json['firebase_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    countryCode = json['country_code'];
    firebaseUid = json['firebase_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['profile'] = this.profile;
    data['type'] = this.type;
    data['fcm_id'] = this.fcmId;
    data['notification'] = this.notification;
    data['firebase_id'] = this.firebaseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['country_code'] = this.countryCode;
    data['firebase_uid'] = this.firebaseUid;
    return data;
  }
}
