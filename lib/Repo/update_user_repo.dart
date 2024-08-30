import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class UpdateUserRepo{
  Future<dynamic> updateChannelDetail(String? channelName, String? channelLogo, String? channelBanner) async {
    try{
      final response = await ApiBaseHelper().postAPICall(editChannelUrl, {
        'name': channelName!,
        'logo': channelLogo!,
        'banner': channelBanner!
      });

      if(response.statusCode == 200){

        print('The channel is successfully updated');
      }
    }catch(e){
      throw ApiException('Fail to call update user API');
    }
  }
}