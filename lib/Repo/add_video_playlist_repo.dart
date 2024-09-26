import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';

class AddVideoToPlaylistRepo{
  Future<dynamic> addVideoToPlaylist(List<int> playlistIds, int videoId) async {
    try{
      final response = await ApiBaseHelper().postAPICall(
          '${apiUrl}playlists/videos',
          {
            'video_id': videoId,
            'playlist_ids': playlistIds
          });
      if(response.statusCode == 200){
        print('Video successfully added to playlist');
        return response.data['message'];
      }
    }catch(e){
      throw ApiException('Fail to call Add video to playlist API  ${e.toString()}');
    }
  }
}