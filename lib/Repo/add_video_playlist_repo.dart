import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';

class AddVideoToPlaylistRepo{
  Future<void> addVideoToPlaylist(int playlistId, int videoId) async {
    try{
      final response = await ApiBaseHelper().postAPICall(
          '${apiUrl}playlists/$playlistId/videos',
          {'video_id': videoId});
      if(response.statusCode == 200){
        print('Video successfully added to playlist');
      }
    }catch(e){
      throw ApiException('Fail to call Add video to playlist API  ${e.toString()}');
    }
  }
}