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