// global.dart

import 'package:hive/hive.dart';
import '../model/user_data_model.dart';

class Global {
  static UserDataModel? _userData;

  static Future<void> initialize() async {
    var box = await Hive.openBox<UserDataModel>('UserDataBox');
    _userData = box.get('UserData');
    print('Initialized UserData: $_userData');
  }

  static Future<void> setUserData(
      String userToken,
      String userId,
      String userName,
      String userNumber,
      String userEmail,
      String userProfilePhoto,
      String userChannelId) async {
    var box = await Hive.openBox<UserDataModel>('UserDataBox');
    var userData = UserDataModel(
      userToken: userToken,
      userId: userId,
      userName: userName,
      userNumber: userNumber,
      userEmail: userEmail,
      userProfilePhoto: userProfilePhoto,
      userChannelId: userChannelId,
    );
    await box.put('UserData', userData);
    _userData = userData;
    print('Set UserData: $userData');
  }

  static Future<void> clearUserData() async {
    var box = await Hive.openBox<UserDataModel>('UserDataBox');
    await box.delete('UserData');
    _userData = null;
  }

  static UserDataModel? get userData => _userData;
}








// import 'package:hive/hive.dart';
//
// class Global {
//   static String? _token;
//
//   static Future<void> initialize() async {
//     var box = await Hive.openBox('UserData');
//     _token = box.get('token');
//
//   }
//   static Future<void> setToken(String token) async {
//     var box = await Hive.openBox('UserData');
//     await box.put('token', token);
//     _token = token;
//   }
//
//
//   static Future<void> clearUserData() async {
//     var box = await Hive.openBox('UserData');
//     await box.delete('token');
//     _token = null;
//   }
//
//
//   static String? get token => _token;
// }


// void saveToken(String token) async {
//   await Global.setToken(token);
// }



// _name = box.get('name');
// _profilePhoto = box.get('profilePhoto');



// await box.put('name', name);
// await box.put('profilePhoto', profilePhoto);
// _name = name;
// _profilePhoto = profilePhoto;




// await box.delete('name');
// await box.delete('profilePhoto');




// static String? get name => _name;
// static String? get profilePhoto => _profilePhoto;




// static String? _name;
// static String? _profilePhoto;




























































// import 'package:hive/hive.dart';
//
// import '../model/user_data_model.dart';
//
// class Global {
//   // static String? _token;
//   // static String? _userId;
//   // static String? _userName;
//   // static String? _userProfile;
//   // static String? _userNumber;
//   // static String? _userEmail;
//   // static String? _userChannelId;
//   static List<UserDataModel>? _userData;
//
//
//
//   static Future<void> initialize() async {
//     var box = await Hive.openBox('UserData');
//     _userData = box.get('UserData');
//   }
//
//   static Future<void> setUserData(List<UserDataModel> userData) async {
//     print('//////////////    ${userData.first.token}');
//     var box = await Hive.openBox('UserData');
//     await box.put('userData', userData);
//     _userData = userData;
//   }
//
//   // static Future<void> setToken(String token) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('token', token);
//   //   _token = token;
//   // }
//   //
//   // static Future<void> setUserName(String userName) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('userName', userName);
//   //   _userName = userName;
//   // }
//   //
//   // static Future<void> setUserProfile(String userProfile) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('userProfile', userProfile);
//   //   _userProfile = userProfile;
//   // }
//   //
//   // static Future<void> setUserNumber(String userNumber) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('userNumber', userNumber);
//   //   _userNumber = userNumber;
//   // }
//   //
//   // static Future<void> setUserEmail(String userEmail) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('userEmail', userEmail);
//   //   _userEmail = userEmail;
//   // }
//   //
//   // static Future<void> setUserChannelId(String userChannelId) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('userChannelId', userChannelId);
//   //   _userChannelId = userChannelId;
//   // }
//   //
//   // static Future<void> setUserId(String userId) async {
//   //   var box = await Hive.openBox('UserData');
//   //   await box.put('userId', userId);
//   //   _userId = userId;
//   // }
//
//   static Future<void> clearUserData() async {
//     var box = await Hive.openBox('UserData');
//     // await box.delete('token');
//     // await box.delete('userId');
//     // await box.delete('userName');
//     // await box.delete('userProfile');
//     // await box.delete('userNumber');
//     // await box.delete('userEmail');
//     // await box.delete('userChannelId');
//     await box.delete('UserData');
//     _userData = null;
//     // _token = null;
//     // _userId = null;
//     // _userName = null;
//     // _userProfile = null;
//     // _userNumber = null;
//     // _userEmail = null;
//     // _userChannelId = null;
//   }
//
//   static List<UserDataModel>? get userData => _userData;
// // static String? get token => _token;
// // static String? get userId => _userId;
// // static String? get userName => _userName;
// // static String? get userProfile => _userProfile;
// // static String? get userNumber => _userNumber;
// // static String? get userEmail => _userEmail;
// // static String? get userChannelId => _userChannelId;
// }