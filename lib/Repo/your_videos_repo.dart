import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';

class YourVideosRepo{
  Future<List<GetChannelDetailModel>?> getYourVideos()async{
   try{
     final String? channelId = Global.userData!.userChannelId;
     final response = await ApiBaseHelper().getAPICall('${apiUrl}channels/${channelId}', {});

     print('${response.data}');

     if(response.statusCode == 200){
       List<GetChannelDetailModel> yourVideoData = [];
       yourVideoData.add(GetChannelDetailModel.fromJson(response.data));

       return yourVideoData;
     }else{
       return throw ApiException('Fail to Get Your Video ${response.statusCode}');
     }
   }catch(e){
     throw ApiException('Fail to call API');
   }
   return null;
  }

}
