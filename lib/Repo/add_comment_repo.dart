import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';

class AddCommentRepo{
  Future<dynamic> addUserComment(String videoSlug, String userComment) async {
    try{
      final response = await ApiBaseHelper().postAPICall('${apiUrl}videos/$videoSlug/comment', {
        'comment': userComment
      });

      if(response.statusCode == 200){
        print('Comment added Successfully');
      }
    }catch(e){
      throw ApiException('Fail to call add comment API ${e.toString()}');
    }
  }
}