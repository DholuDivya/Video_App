import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_all_channels_model.dart';

class GetAllChannelsRepo{
  Future<List<GetAllChannelsModel>?> getAllChannelsList() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getAllChannelsListUrl, {});
      if(response.statusCode == 200){
        List<GetAllChannelsModel> channelsList = [];
        channelsList.add(GetAllChannelsModel.fromJson(response.data));
        return channelsList;
      }
    }catch(e){
      throw ApiException('Failed to call get all channels list API');
    }
    return null;
  }
}