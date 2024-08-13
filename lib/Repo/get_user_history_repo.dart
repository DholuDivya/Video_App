import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/user_history_model.dart';

class GetUserHistoryRepo{
  Future<List<UserHistoryModel>?> getUserHistory() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getUserHistoryUrl, {});
      if(response.statusCode == 200){
        List<UserHistoryModel> userHistory = [];
        userHistory.add(UserHistoryModel.fromJson(response.data));
        return userHistory;
      }
    }catch(e){
      throw ApiException('Fail to call Get User History API    ${e.toString()}');
    }
    return null;
  }
}