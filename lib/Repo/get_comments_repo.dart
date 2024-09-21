import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/model/get_comments_model.dart';

class GetCommentsRepo{
  Future<Map<String, dynamic>> getComments(String videoSlug, int limit, int offset) async {
    try{
      print('RRREPO');
      final response = await ApiBaseHelper().getAPICall('${apiUrl}videos/$videoSlug/comments', {
        'limit': limit,
        'offset': offset
      });
      if(response.statusCode == 200){
        // final List<GetCommentsModel> getCommentsList = [];
        // getCommentsList.add(GetCommentsModel.fromJson(response.data));
        // print(' tytytyttytyytytytytytytytytytytytytyttytyttyty');
        // print('{{{{{{{{{{{{{{{[      $getCommentsList');
        return response.data as Map<String, dynamic>;
      }
    }catch(e){
      throw ApiException('Fail to call get comments API');
    }
    return {};
  }
}