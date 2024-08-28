import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/like_dislike_comment_model.dart';

class LikeDislikeCommentRepo{
  Future<List<LikeDislikeCommentModel>?> likeComment(int commentId) async {
    try{
      final response = await ApiBaseHelper().postAPICall('$likeCommentUrl$commentId/like', {});
      if(response.statusCode == 200){
        List<LikeDislikeCommentModel> likeCommentData = [];
        likeCommentData.add(LikeDislikeCommentModel.fromJson(response.data));
        return likeCommentData;
      }
    }catch(e){
      throw ApiException('Fail to call like API  ${e.toString()}');
    }
    return null;
  }

  Future<List<LikeDislikeCommentModel>?> dislikeComment(int commentId) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall('$likeCommentUrl$commentId/dislike', {});
      if(response.statusCode == 200){
        List<LikeDislikeCommentModel> dislikeCommentData = [];
        dislikeCommentData.add(LikeDislikeCommentModel.fromJson(response.data));
        return dislikeCommentData;
      }
    }catch(e){
      throw ApiException('Fail to call like API  ${e.toString()}');
    }
    return null;
  }
}