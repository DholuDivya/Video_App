import '../config/ApiBaseHelper.dart';
import '../config/constants.dart';
import '../config/global_variable.dart';
import '../model/get_channel_detail_model.dart';

class ChannelProfileRepo{
  Future<List<GetChannelDetailModel>?> getChannelProfile(String channelId)async{
    try{
      final response = await ApiBaseHelper().getAPICall('${apiUrl}channels/${channelId}', {});

      print('${response.data}');

      if(response.statusCode == 200){
        List<GetChannelDetailModel> yourVideoData = [];
        yourVideoData.add(GetChannelDetailModel.fromJson(response.data));
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