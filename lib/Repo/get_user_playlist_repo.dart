import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_user_playlist_model.dart';

class GetUserPlaylistRepo{
  Future<List<GetUserPlaylistModel>?> getUserPlaylist() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getUserPlaylistUrl, {});
      if(response.statusCode == 200){
        print('Successfully fetched user playlist');
      }
    }catch(e){
      throw ApiException('Fail to call get user playlist API');
    }
    return null;
  }
}