import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/model/get_your_videos_model.dart';

class YourVideosRepo{
  Future<List<GetYourVideosModel>?> getYourVideos()async{
   try{
     final String? channelId = Global.userData!.userChannelId;
     final response = await ApiBaseHelper().getAPICall('${apiUrl}channels/$channelId', {});

     print('${response.data}');

     if(response.statusCode == 200){
       print('giorghnroigbhrgbbrbg');
       List<GetYourVideosModel> yourVideoData = [];
       yourVideoData.add(GetYourVideosModel.fromJson(response.data));
       print('Your videos successfully fetched  $yourVideoData');
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
