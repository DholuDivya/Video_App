import '../config/ApiBaseHelper.dart';
import '../config/constants.dart';
import '../config/global_variable.dart';
import '../model/get_your_videos_model.dart';

class ChannelProfileRepo{
  Future<List<GetYourVideosModel>?> getChannelProfile(String channelId)async{
    try{
      final response = await ApiBaseHelper().getAPICall('${apiUrl}channels/${channelId}', {});

      print('${response.data}');

      if(response.statusCode == 200){
        List<GetYourVideosModel> yourVideoData = [];
        yourVideoData.add(GetYourVideosModel.fromJson(response.data));
        print('Channel Profile Successfully Fetched');
        return yourVideoData;
      }else{
        return throw ApiException('Fail to Get Channel Profile ${response.statusCode}');
      }
    }catch(e){
      throw ApiException('Fail to call API');
    }
    return null;
  }
}