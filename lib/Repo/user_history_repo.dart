import 'package:vimeo_clone/config/ApiBaseHelper.dart';

class UserHistoryRepo{
  Future<void> addWatchedVideo(String lastDuration, String videoSlug) async {
    try{
      final response = await ApiBaseHelper().postAPICall('https://videoapp.taskhub.company/api/videos/${videoSlug}/watched',
          {'duration_watched': lastDuration});
      if(response.statusCode == 200){
        print('Successfully Video Added To History');
      }
    }catch(e){
      throw ApiException('Fail to call add watched video in history API');
    }
  }
}