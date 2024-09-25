import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class YourShortsRepo{
  Future<Map<String, dynamic>> yourShorts(int channelId, int limit, int offset) async {
    try{
      final response = await ApiBaseHelper().getAPICall('$yourShortsUrl$channelId/shorts', {
        'limit': limit,
        'offset': offset
      });
      if(response.statusCode == 200){
        return response.data as Map<String, dynamic>;
      }
    }catch(e){
      throw ApiException('Fail to call your shorts API');
    }
    return {};
  }
}