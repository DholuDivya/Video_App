import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/settings_api_model.dart';

class SettingsApiRepo{
  Future<List<SettingsApiModel>?> settingsApi() async {
    try {
      final response = await ApiBaseHelper().getAPICall(settingsApiUrl, {});
      if (response.statusCode == 200) {
        List<SettingsApiModel> settingsApiData = [];
        settingsApiData.add(SettingsApiModel.fromJson(response.data));
        return settingsApiData;
      }
    } catch (e) {
      throw ApiException('Fail to call settings API');
    }
    return null;
  }
}