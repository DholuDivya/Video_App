import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

import '../model/get_shorts_list_model.dart';

class GetShortsBySlugRepo{
  Future<List<GetShortsListModel>?> getShortsBySlug(String shortsSlug) async {
    final response = await ApiBaseHelper().getAPICall(getShortsBySlugUrl, {
      'slug': shortsSlug
    });
    if(response.statusCode == 200){
      List<GetShortsListModel> shortData = [];
      shortData.add(GetShortsListModel.fromJson(response.data));
      print('Shorts fetched successfully');
      return shortData;
    }
    return null;
  }
}