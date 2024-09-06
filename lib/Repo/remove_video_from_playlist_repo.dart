import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class RemoveVideoFromPlaylistRepo{
  Future<void> RemoveVideoFromPlaylist(int playlistId, List<int> videoIds) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall('$removeVideoFromPlaylistUrl/$playlistId/videos', {
        'video_id': videoIds
      });

      if(response.statusCode == 200){
        print('Video successfully Removed from playlist');
      }
    }catch(e){
      throw ApiException(e.toString());
    }
  }
}