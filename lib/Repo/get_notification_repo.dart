import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_notification_model.dart';

class GetNotificationRepo{
  Future<List<GetNotificationModel>?> getNotification() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getNotificationUrl, {});
      if(response.statusCode == 200){
        List<GetNotificationModel> notificationData = [];
        notificationData.add(GetNotificationModel.fromJson(response.data));
        print('Notification fetched successfully');
        return notificationData;
      }
    }catch(e){
      throw ApiException('Fail to call notification');
    }
    return null;
  }
}