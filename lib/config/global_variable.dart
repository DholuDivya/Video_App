// global.dart
import 'package:hive/hive.dart';

class Global {
  static String? _token;

  static Future<void> initialize() async {
    // Open the Hive box
    var box = await Hive.openBox('UserData');
    // Load the token from Hive and set it to _token
    _token = box.get('token');
  }

  static Future<void> setToken(String token) async {
    // Open the Hive box
    var box = await Hive.openBox('UserData');
    // Save the token in Hive
    await box.put('token', token);
    // Set the token in the class
    _token = token;
  }


  static Future<void> clearToken() async {
    var box = await Hive.openBox('myBox');
    await box.delete('token');
    _token = null;
  }

  static String? get token => _token;
}


// void saveToken(String token) async {
//   await Global.setToken(token);
// }