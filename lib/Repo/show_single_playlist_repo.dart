import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/model/show_single_playlist_model.dart';

import '../config/api_routes.dart';

class ShowSinglePlaylistRepo{
  Future<Map<String, dynamic>> showSinglePlaylist(int playlistId, int limit, int offset) async {
    try{
      final response = await ApiBaseHelper().getAPICall('$showSinglePlaylistUrl$playlistId', {
        'limit': limit,
        'offset': offset
      });

      if(response.statusCode == 200){
        List<ShowSinglePlaylistModel> singlePlaylistData = [];
        singlePlaylistData.add(ShowSinglePlaylistModel.fromJson(response.data));
        return response.data as Map<String, dynamic>;
      }
    }catch(e){
      throw ApiException('Fail to call single playlist API');
    }
    return {};
  }
}