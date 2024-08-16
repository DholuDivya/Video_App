import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class CreatePlaylistRepo{
  Future<void> createPlaylist(String playlistTitle, String playlistDescription, String playlistStatus) async {
    try{
      final response = await ApiBaseHelper().postAPICall(
          createPlaylistUrl,
          {
            'title': playlistTitle,
            'description': playlistDescription,
            'status': playlistStatus
          });

      if(response.statusCode == 201){
        print('The playlist is created successfully');
      } else {
        print('Failed to create playlist ');
      }
    }catch(e){
      throw ApiException('Fail to call create playlist  API ::: ${e.toString()}');
    }
  }
}