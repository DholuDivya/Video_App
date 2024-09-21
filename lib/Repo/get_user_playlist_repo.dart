import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

class GetUserPlaylistRepo{
  Future<Map<String, dynamic>> getUserPlaylist(int limit, int offset) async {
    try{
      final response = await ApiBaseHelper().getAPICall(getUserPlaylistUrl, {
        'limit': limit,
        'offset': offset
      });

      return response.data as Map<String, dynamic>;
    }catch(e){
      throw ApiException('Fail to call get user playlist API');
    }
  }
}