import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class RemoveVideoFromHistoryRepo{
  Future RemoveVideoFromHistory(List<int> videoIds) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall(removeVideoFromHistoryUrl, {
        'video_ids': videoIds
      });

      if(response.statusCode == 200){
        print('Video Removed successfully from user history');
      }
    }catch(e){
      throw ApiException(e.toString());
    }
  }
}