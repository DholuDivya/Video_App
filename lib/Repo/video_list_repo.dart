

import 'dart:convert';
import 'dart:developer';

import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

import '../model/all_video_list_model.dart';
import '../model/video_list_model.dart';

class VideoListRepo {
  Future<Map<String, dynamic>> getVideoList(int categoryId, int limit, int offset) async {
    try {
      final response = await ApiBaseHelper().getAPICall(getVideoListAsCategoryUrl,
          {
            'category_id': categoryId,
            'limit': limit,
            'offset': offset
          });

      log('Response Data: ${response.data}');

      // if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      // }
    } catch (e) {
      log('Error fetching video list: $e');
      throw ApiException('Failed To Call Api');
    }
  }
}
