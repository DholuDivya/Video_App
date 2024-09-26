import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class RemoveVideoFromPlaylistRepo{
  Future<void> removeVideoFromPlaylist(int playlistId, int videoId) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall('$removeVideoFromPlaylistUrl$playlistId/videos', {
        'video_id': videoId
      });

      if(response.statusCode == 200){
        print('Video successfully Removed from playlist');
      }
    }catch(e){
      throw ApiException(e.toString());
    }
  }
}