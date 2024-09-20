import 'dart:convert';

import '../config/ApiBaseHelper.dart';
import '../config/api_routes.dart';
import '../model/all_video_list_model.dart';

class AllVideoListRepo{


  Future<Map<String, dynamic>> getAllVideoList(int limit, int offset) async {
    try {
      final response = await ApiBaseHelper().getAPICall(getAllVideoListUrl, {
          'limit': limit,
          'offset': offset
      });
return response.data as Map<String, dynamic>;


      // if (response.statusCode == 200) {
      //
      //   List<AllVideoListModel> videoData = [];
      //   videoData.add(AllVideoListModel.fromJson(response.data));
      //
      //
      //   // var jsonResponse;
      //   // if (response.data is String) {
      //   //   jsonResponse = json.decode(response.data);
      //   // } else {
      //   //   jsonResponse = response.data;
      //   // }
      //   //
      //   // // Log the entire jsonResponse to understand its structure
      //   // print('JSON Response: $jsonResponse');
      //
      //   // Ensure jsonResponse contains the expected structure
      //   // if (jsonResponse['data'] != null &&
      //   //     jsonResponse['data']['data'] != null &&
      //   //     jsonResponse['data']['data'] is List) {
      //   //   final List<VideoData> videoList = [];
      //   //   var video = jsonResponse['data']['data'] as List<dynamic>;
      //   //
      //   //   // Convert each video item to a Data object
      //   //   for (var row in video) {
      //   //     videoList.add(VideoData.fromJson(row as Map<String, dynamic>));
      //   //   }
      //   //
      //   //   print('Video List: $videoList');
      //   //   print('Video List retrieved successfully');
      //   //   return videoList;
      //   // } else {
      //   //   print('Unexpected JSON structure: $jsonResponse');
      //   //   throw ApiException('Unexpected JSON structure');
      //   // }
      // } else {
      //   print('Failed to get the list of Videos');
      //   throw ApiException('Failed to get the list of Videos');
      // }
    } catch (e) {
      print('Error: $e');
      throw ApiException('Failed to call API');
    }
  }


  // Future<List<Data>?> getAllVideoList() async {
  //   try{
  //     final response = await ApiBaseHelper().getAPICall(getAllVideoListUrl, {});
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse;
  //       if (response.data is String) {
  //         jsonResponse = json.decode(response.data);
  //       } else {
  //         jsonResponse = response.data;
  //       }
  //
  //       // Log the entire jsonResponse to understand its structure
  //       print('JSON Response: $jsonResponse');
  //
  //       // Ensure jsonResponse contains the expected structure
  //       if (jsonResponse['data'] != null && jsonResponse['data'] is List) {
  //         final List<Data> videoList = [];
  //         var video = jsonResponse['data'] as List<dynamic>;
  //
  //         // Convert each video item to a Data object
  //         for (var row in video) {
  //           videoList.add(Data.fromJson(row as Map<String, dynamic>));
  //         }
  //
  //         print('Video List: $videoList');
  //         print('Video List retrieved successfully');
  //         return videoList;
  //       } else {
  //         print('Unexpected JSON structure: $jsonResponse');
  //         throw ApiException('Unexpected JSON structure');
  //       }
  //     }else{
  //       print('Failed Get the list of Videos');
  //     }
  //
  //   }catch(e){
  //     throw ApiException('Failed call Api');
  //   }
  //   return null;
  // }

}