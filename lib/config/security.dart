

import 'package:vimeo_clone/config/global_variable.dart';

Map<String, String>? get headers {
  final String? token = Global.token;
  if (token != null && token.toString().trim().isNotEmpty) {
    return {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
      // 'Authorization': 'Bearer $token'
    };
  }
  return null;
}




void saveToken(String token) async {
  await Global.setToken(token);
}