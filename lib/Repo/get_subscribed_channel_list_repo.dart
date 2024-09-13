import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_subscribed_channel_list_model.dart';

class GetAllChannelsRepo{
  Future<List<GetSubscribedChannelListModel>?> getAllChannelsList() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getSubscribedChannelListUrl, {});
      if(response.statusCode == 200){
        List<GetSubscribedChannelListModel> channelsList = [];
        channelsList.add(GetSubscribedChannelListModel.fromJson(response.data));
        print('Message ::: ${channelsList.first.message}');
        return channelsList;
      }
    }catch(e){
      throw ApiException('Failed to call get all channels list API');
    }
    return null;
  }
}