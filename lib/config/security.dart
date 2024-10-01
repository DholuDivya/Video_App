import 'package:vimeo_clone/config/global_variable.dart';

Map<String, String>? get headers {
  final String? token = Global.userData!.userToken;
  final String language = Global.userData!.language!;
  if (token != null && token.toString().trim().isNotEmpty) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-language': language,
      'Authorization': 'Bearer $token',
    };
  }
  return null;
}
