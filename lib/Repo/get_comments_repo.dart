import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/model/get_comments_model.dart';

class GetCommentsRepo{
  Future<List<GetCommentsModel>?> getComments(String videoSlug) async {
    try{
      final response = await ApiBaseHelper().getAPICall('${apiUrl}videos/$videoSlug/comments', {});
      if(response.statusCode == 200){
        final List<GetCommentsModel> getCommentsList = [];
        getCommentsList.add(GetCommentsModel.fromJson(response.data));
        print(' tytytyttytyytytytytytytytytytytytytyttytyttyty');
        print('{{{{{{{{{{{{{{{[      $getCommentsList');
        return getCommentsList;
      }
    }catch(e){
      throw ApiException('Fail to call get comments API');
    }
    return null;
  }
}