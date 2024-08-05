

import 'dart:convert';
import 'dart:developer';

import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

import '../model/all_video_list_model.dart';
import '../model/video_list_model.dart';

class VideoListRepo {
  Future<List<Videos>?> getVideoList(int categoryId) async {
    try {
      final response = await ApiBaseHelper().getAPICall(getVideoListAsCategoryUrl, {'category_id': categoryId});

      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        var jsonResponse;
        if (response.data is String) {
          jsonResponse = json.decode(response.data);
        } else {
          jsonResponse = response.data['category'];
        }

        // Log the entire jsonResponse to understand its structure
        log('JSON Response: $jsonResponse');

        // Ensure jsonResponse contains the expected structure
        if (jsonResponse != null) {
          if (jsonResponse is Map && jsonResponse.containsKey('videos') && jsonResponse['videos'] is List) {
            final List<Videos> videoList = [];
            var video = jsonResponse['videos'] as List<dynamic>;

            // Convert each video item to a Videos object
            for (var row in video) {
              log('Processing video item: $row');
              videoList.add(Videos.fromJson(row as Map<String, dynamic>));
            }

            log('Video List: $videoList');
            log('Video List retrieved successfully');
            return videoList;
          } else {
            log('JSON structure does not contain expected "videos" key or it is not a List: $jsonResponse');
            throw ApiException('Unexpected JSON structure');
          }
        } else {
          log('JSON response is null');
          throw ApiException('Unexpected JSON structure');
        }
      } else {
        log('Failed to get the list of videos, status code: ${response.statusCode}');
        throw ApiException('Failed to get the list of videos');
      }
    } catch (e) {
      log('Error fetching video list: $e');
      throw ApiException('Failed To Call Api');
    }
  }
}
