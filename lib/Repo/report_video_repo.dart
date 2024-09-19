import 'package:vimeo_clone/config/ApiBaseHelper.dart';

import '../config/api_routes.dart';

class ReportVideoRepo{
  Future<dynamic> reportVideoRepo(int userId, int videoId, String reportContent) async {
    try{
      final response = await ApiBaseHelper().postAPICall(reportVideoUrl, {
        'user_id': userId,
        'video_id': videoId,
        'report_content': reportContent
      });
      
      if(response.statusCode == 201){
        print('MESSAGE: ${response.data['message']}');
        return response.data['message'];
      }
    }catch(e){
      throw ApiException('Fail to report the video');
    }
  }
}