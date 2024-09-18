import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/constants.dart';

class UserHistoryRepo{
  Future<void> addWatchedVideo(String lastDuration, String videoSlug) async {
    try{
      final response = await ApiBaseHelper().postAPICall('${apiUrl}videos/$videoSlug/watched',
          {'duration_watched': lastDuration});
      if(response.statusCode == 200){
        print('Successfully Video Added To History');
      }
    }catch(e){
      throw ApiException('Fail to call add watched video in history API');
    }
  }
}