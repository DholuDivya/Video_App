import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/app_privacy_content_model.dart';

class AppPrivacyContentRepo{
  Future<List<AppPrivacyContentModel>?> appPrivacyContentRepo() async {
    try{
      final response = await ApiBaseHelper().getAPICall(appPrivacyContentUrl, {});

      if(response.statusCode == 200){
        List<AppPrivacyContentModel> appPrivacyContentData = [];
        appPrivacyContentData.add(AppPrivacyContentModel.fromJson(response.data));
        print('Successfully fetched privacy data');
        return appPrivacyContentData;
      }
    }catch(e){
      throw ApiException('Fail to call app privacy content');
    }
    return null;
  }
}