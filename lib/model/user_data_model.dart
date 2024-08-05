// class UserDataModel {
//   bool? error;
//   String? status;
//   String? message;
//   UserData? user;
//   String? token;
//   Channels? channel;
//
//   UserDataModel(
//       {this.error,
//         this.status,
//         this.message,
//         this.user,
//         this.token,
//         this.channel});
//
//   UserDataModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     status = json['status'];
//     message = json['message'];
//     user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
//     token = json['token'];
//     channel =
//     json['channel'] != null ? new Channels.fromJson(json['channel']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['token'] = this.token;
//     if (this.channel != null) {
//       data['channel'] = this.channel!.toJson();
//     }
//     return data;
//   }
// }
//
// class UserData {
//   int? id;
//   String? name;
//   String? email;
//   String? phoneNumber;
//   String? emailVerifiedAt;
//   String? profile;
//   String? type;
//   String? fcmId;
//   int? notification;
//   String? firebaseId;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   String? countryCode;
//   List<Channels>? channels;
//
//   UserData(
//       {this.id,
//         this.name,
//         this.email,
//         this.phoneNumber,
//         this.emailVerifiedAt,
//         this.profile,
//         this.type,
//         this.fcmId,
//         this.notification,
//         this.firebaseId,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.countryCode,
//         this.channels});
//
//   UserData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phoneNumber = json['phone_number'];
//     emailVerifiedAt = json['email_verified_at'];
//     profile = json['profile'];
//     type = json['type'];
//     fcmId = json['fcm_id'];
//     notification = json['notification'];
//     firebaseId = json['firebase_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     countryCode = json['country_code'];
//     if (json['channels'] != null) {
//       channels = <Channels>[];
//       json['channels'].forEach((v) {
//         channels!.add(new Channels.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone_number'] = this.phoneNumber;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['profile'] = this.profile;
//     data['type'] = this.type;
//     data['fcm_id'] = this.fcmId;
//     data['notification'] = this.notification;
//     data['firebase_id'] = this.firebaseId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     data['country_code'] = this.countryCode;
//     if (this.channels != null) {
//       data['channels'] = this.channels!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Channels {
//   int? id;
//   String? name;
//   String? slug;
//   String? description;
//   String? logo;
//   String? bannerImage;
//   String? status;
//   String? deletedAt;
//   String? region;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   Channels(
//       {this.id,
//         this.name,
//         this.slug,
//         this.description,
//         this.logo,
//         this.bannerImage,
//         this.status,
//         this.deletedAt,
//         this.region,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   Channels.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     description = json['description'];
//     logo = json['logo'];
//     bannerImage = json['banner_image'];
//     status = json['status'];
//     deletedAt = json['deleted_at'];
//     region = json['region'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['description'] = this.description;
//     data['logo'] = this.logo;
//     data['banner_image'] = this.bannerImage;
//     data['status'] = this.status;
//     data['deleted_at'] = this.deletedAt;
//     data['region'] = this.region;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
// class Pivot {
//   int? userId;
//   int? channelId;
//
//   Pivot({this.userId, this.channelId});
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     channelId = json['channel_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['channel_id'] = this.channelId;
//     return data;
//   }
// }










import 'package:hive/hive.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: 0)
class UserDataModel{
  @HiveField(0)
  String? userToken;

  @HiveField(1)
  String? userId;

  @HiveField(2)
  String? userName;

  @HiveField(3)
  String? userNumber;

  @HiveField(4)
  String? userEmail;

  @HiveField(5)
  String? userProfilePhoto;

  @HiveField(6)
  String? userChannelId;

  UserDataModel({
    this.userToken,
    this.userId,
    this.userName,
    this.userEmail,
    this.userNumber,
    this.userProfilePhoto,
    this.userChannelId
  });
}