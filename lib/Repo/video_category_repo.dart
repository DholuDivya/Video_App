import 'dart:convert';

import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/security.dart';

import '../model/video_categories_model.dart';


class VideoCategoriesRepo{
  
  Future<List<Category>?> getVideoCategories() async {
    print(getCategoriesUrl);
    print(headers);
    try{
      final response = await ApiBaseHelper().getAPICall(getCategoriesUrl, {});
      print(response.data['categories']);
      var responseData = response.data['categories'];
      List<Category> videoCategory = [];
      if(response.statusCode == 200 ){

        var categories = responseData as List<dynamic>;
        for(var i = 0; i<categories.length; i++){
          var row = categories[i] as Map<String, dynamic>;
          videoCategory.add(Category.fromJson(row));
        }
        print('Categories successfully added');
        print('-------------------------------    ${videoCategory}');
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