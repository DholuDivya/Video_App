import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

class GetUserPlaylistRepo{
  Future<Map<String, dynamic>> getUserPlaylist(int channelId, int limit, int offset) async {
    try{
      final response = await ApiBaseHelper().getAPICall('$getUserPlaylistUrl$channelId/playlist', {
        'limit': limit,
        'offset': offset
      });

      print('tttttttttttt    ${response.data}');
      return response.data as Map<String, dynamic>;
    }catch(e){
      throw ApiException('Fail to call get user playlist API');
    }
  }
}