// global.dart


import 'package:hive/hive.dart';

class Global {
  static String? _token;
  static String? _userName;
  static String? _userProfile;
  static String? _userNumber;
  static String? _userEmail;
  // static String? _userNumber;


  static Future<void> initialize() async {
    var box = await Hive.openBox('UserData');
    _token = box.get('token');
    _userName = box.get('userName');
    _userProfile = box.get('userProfile');
    _userNumber = box.get('userNumber');
    _userEmail = box.get('userEmail');
  }

  static Future<void> setToken(String token) async {
    var box = await Hive.openBox('UserData');
    await box.put('token', token);
    _token = token;
  }

  static Future<void> setUserName(String userName) async {
    var box = await Hive.openBox('UserData');
    await box.put('userName', userName);
    _userName = userName;
  }

  static Future<void> setUserProfile(String userProfile) async {
    var box = await Hive.openBox('UserData');
    await box.put('userProfile', userProfile);
    _userProfile = userProfile;
  }

  static Future<void> setUserNumber(String userNumber) async {
    var box = await Hive.openBox('UserData');
    await box.put('userNumber', userNumber);
    _userNumber = userNumber;
  }

  static Future<void> setUserEmail(String userEmail) async {
    var box = await Hive.openBox('UserData');
    await box.put('userEmail', userEmail);
    _userEmail = userEmail;
  }

  static Future<void> clearUserData() async {
    var box = await Hive.openBox('UserData');
    await box.delete('token');
    await box.delete('userName');
    await box.delete('userProfile');
    await box.delete('userNumber');
    await box.delete('userEmail');
    _token = null;
    _userName = null;
    _userProfile = null;
    _userNumber = null;
    _userEmail = null;
  }

  static String? get token => _token;
  static String? get userName => _userName;
  static String? get userProfile => _userProfile;
  static String? get userNumber => _userNumber;
  static String? get userEmail => _userEmail;
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