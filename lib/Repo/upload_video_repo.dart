import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class UploadVideoRepo {
  Future<dynamic> uploadVideo(dynamic formData)async{
    try{
      print('^^^^^^^^^^^^      ${formData}');

      final response = await ApiBaseHelper().postAPICall('https://videoapp.taskhub.company/api/video', formData);
      print('1111111111111111111111111');

      if(response.statusCode == 200){
        return response.data;
      }else{
        return "Errrrroooorrrrr";
      }
    }catch(e){
      throw ApiException('Failed to call api of upload video');
    }
  }
}