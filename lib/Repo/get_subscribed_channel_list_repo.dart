import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_subscribed_channel_list_model.dart';

class GetAllChannelsRepo{
  Future<Map<String, dynamic>> getAllChannelsList(int limit, int offset) async {
    try{
      final response = await ApiBaseHelper().getAPICall(getSubscribedChannelListUrl, {
        'limit': limit,
        'offset': offset
      });
      return response.data as Map<String, dynamic>;

    }catch(e){
      throw ApiException('Failed to call get all channels list API');
    }
  }
}