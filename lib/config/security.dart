import 'package:vimeo_clone/config/global_variable.dart';

Map<String, String>? get headers {
  final String? token = Global.token;
  if (token != null && token.toString().trim().isNotEmpty) {
    return {
      'Content-Type': 'application/json',
      // 'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  return null;
}
