import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/model/show_single_playlist_model.dart';

import '../config/api_routes.dart';

class ShowSinglePlaylistRepo{
  Future<List<ShowSinglePlaylistModel>?> showSinglePlaylist(int playlistId) async {
    try{
      final response = await ApiBaseHelper().getAPICall('$showSinglePlaylistUrl$playlistId', {});

      if(response.statusCode == 200){
        List<ShowSinglePlaylistModel> singlePlaylistData = [];
        singlePlaylistData.add(ShowSinglePlaylistModel.fromJson(response.data));
        return singlePlaylistData;
      }
    }catch(e){
      throw ApiException('Fail to call single playlist API');
    }
    return null;
  }
}