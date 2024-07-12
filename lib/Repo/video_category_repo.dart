import 'dart:convert';

import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

import '../model/video_categories_model.dart';


class VideoCategoriesRepo{
  
  Future<List<VideoCategoriesModel>?> getVideoCategories() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getCategoriesUrl);

      List<VideoCategoriesModel> videoCategory = [];
      if(response.statusCode == 200 ){
        var categories = response.data as List<dynamic>;
        for(var i = 0; i<categories.length; i++){
          var row = categories[i] as Map<String, dynamic>;
          videoCategory.add(VideoCategoriesModel.fromJson(row));
        }
        print('Categories successfully added');
        return videoCategory;
      }else{
        print('Failed to add categories');
      }

    }catch(e){
      throw ApiException('Failed to load Categories');
    }
    return null;
  }
}