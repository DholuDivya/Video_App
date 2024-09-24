import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';

class UserTransactionRepo {
  Future<Map<String, dynamic>> userTransaction(int limit, int offset) async {
    try{
      final userId = Global.userData!.userId;
      final response = await ApiBaseHelper().getAPICall('$userTransactionUrl$userId/transactions', {
        'limit': limit,
        'offset': offset
      });
      if(response.statusCode == 200){
        return response.data as Map<String, dynamic>;
      }
    }catch(e){
      throw ApiException('Fail to call transaction API');
    }
    return {};
  }
}