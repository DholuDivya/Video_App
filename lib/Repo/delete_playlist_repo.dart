import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class DeletePlaylistRepo {
  Future deletePlaylist(int playlistId) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall('$deletePlaylistUrl$playlistId', {});

      if(response.statusCode == 200){
        print('Playlist delete successfully');
      }
    }catch(e){
      throw ApiException(e.toString());
    }
  }
}