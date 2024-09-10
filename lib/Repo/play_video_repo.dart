
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/play_video_model.dart';

class PlayVideoRepo{

  Future<List<PlayVideoModel>> getVideo(String slug) async{
    print('5656556565665656566');
    try {

      final response = await ApiBaseHelper().getAPICall(getVideoUrl, {'slug': slug});
      List<PlayVideoModel> videoData = [];

      if (response.statusCode == 200) {

        print('Response received successfully');
        videoData.add(PlayVideoModel.fromJson(response.data));
        print('###########   ${videoData}');
        return videoData;
      } else {
        print('Failed to fetch the video, status code: ${response.statusCode}');
        throw ApiException('Failed to fetch the video, status code: ${response.statusCode}');
      }
    }catch(e){
      throw ApiException('Failed to call API');
    }

  }
}