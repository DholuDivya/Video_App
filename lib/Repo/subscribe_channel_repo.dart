import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/model/subscribe_channel_model.dart';

class SubscribeChannelRepo{
  Future<List<SubscribeChannelModel>?> subscribeChannel(int channelId) async {
    try{
      final response = await ApiBaseHelper().postAPICall('$subscribeChannelUrl$channelId', {});

      if(response.statusCode == 201){
        List<SubscribeChannelModel> subscribeChannel = [];
        subscribeChannel.add(SubscribeChannelModel.fromJson(response.data));
        return subscribeChannel;
      }
    }catch(e){
      throw ApiException('Failed to call subscribe channel API');
    }
    return null;
  }

  Future <List<SubscribeChannelModel>?> unsubscribeChannel(int channelId) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall('$unsubscribeChannelUrl$channelId', {});
      if(response.statusCode == 200){
        List<SubscribeChannelModel> subscribeChannel = [];
        subscribeChannel.add(SubscribeChannelModel.fromJson(response.data));
        return subscribeChannel;
      }
    }catch(e){
      throw ApiException('Failed to call unsubscribe channel API');
    }
    return null;
  }
}