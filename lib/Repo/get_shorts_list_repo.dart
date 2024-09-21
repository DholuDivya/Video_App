import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/get_shorts_list_model.dart';

class GetShortsListRepo{
  Future<Map<String, dynamic>> getShortsList(int limit, int offset) async {
    try{
      final response = await ApiBaseHelper().getAPICall(getShortsListUrl, {
        'limit': limit,
        'offset': offset
      });
      print('&&&&&&&&&&&&&&&       ${response.data}');

      return response.data as Map<String, dynamic>;

      // if(response.statusCode == 200){
      //   if(response.data != null){
      //     List<GetShortsListModel> shortsData = [];
      //     shortsData.add(GetShortsListModel.fromJson(response.data));
      //     return shortsData;
      //   }
      //
      //
      // }
    }catch(e){
      throw ApiException('Fail to call get shorts list API');
    }
  }
}