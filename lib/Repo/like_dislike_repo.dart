import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/model/like_dislike_video_model.dart';

class LikeDislikeVideoRepo{
  Future<List<LikeDislikeVideoModel>?> likeVideo(String videoSlug) async {
    try{
      final response = await ApiBaseHelper().postAPICall('${apiUrl}videos/$videoSlug/like', {});
      if(response.statusCode == 200){
        List<LikeDislikeVideoModel> likeDislikeVideo = [];
        likeDislikeVideo.add(LikeDislikeVideoModel.fromJson(response.data));
        return likeDislikeVideo;
      }
    }catch(e){
      throw ApiException('Fail to call like video API');
    }
    return null;
  }

  Future<List<LikeDislikeVideoModel>?> dislikeVideo(String videoSlug) async {
    try{
      final response = await ApiBaseHelper().postAPICall('${apiUrl}videos/$videoSlug/dislike', {});
      if(response.statusCode == 200){
        List<LikeDislikeVideoModel> likeDislikeVideo = [];
        likeDislikeVideo.add(LikeDislikeVideoModel.fromJson(response.data));
        return likeDislikeVideo;
      }
    }catch(e){
      throw ApiException('Fail to call dislike video API');
    }
    return null;
  }

}