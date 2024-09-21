import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/global_variable.dart';

class YourVideosRepo{
  Future<Map<String, dynamic>> getYourVideos(int limit, int offset)async {
    try {
      final String? channelId = Global.userData!.userChannelId;
      final response = await ApiBaseHelper().getAPICall(
          '${apiUrl}channels/$channelId', {
        'limit': limit,
        'offset': offset
      });

      return response.data as Map<String, dynamic>;

      // if(response.statusCode == 200){
      //   print('giorghnroigbhrgbbrbg');
      //   List<GetYourVideosModel> yourVideoData = [];
      //   yourVideoData.add(GetYourVideosModel.fromJson(response.data));
      //   print('Your videos successfully fetched  $yourVideoData');
      //
      // }else{
      //   return throw ApiException('Fail to Get Channel Profile ${response.statusCode}');
      // }
    } catch (e) {
      throw ApiException('Fail to call API');
    }
  }
}
