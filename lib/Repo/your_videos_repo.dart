import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';

class YourVideosRepo{
  Future<Map<String, dynamic>> getYourVideos(int channelId, int limit, int offset)async {
    try {
      final response = await ApiBaseHelper().getAPICall(
          '$yourVideosUrl$channelId/videos', {
        'limit': limit,
        'offset': offset
      });

      if(response.statusCode == 200){
        return response.data as Map<String, dynamic>;
      }
    } catch (e) {
      throw ApiException('Fail to call API');
    }
    return {};
  }
}
