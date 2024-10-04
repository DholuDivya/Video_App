import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class ClearAllHistoryRepo{
  Future<dynamic> clearAllHistory() async {
    try{
      final response = await ApiBaseHelper().deleteAPICall(clearAllHistoryUrl, {});
      if(response.statusCode == 200){
        print('History Cleared');
        return response.data['message'];
      }
    }catch(e){
      throw ApiException('Fail to call clear all history API');
    }
  }
}