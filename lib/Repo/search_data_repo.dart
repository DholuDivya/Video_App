import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/search_data_model.dart';

class SearchDataRepo{
  Future<List<SearchDataModel>?> getSearchData(String searchQuery) async {
    try{
      final response = await ApiBaseHelper().postAPICall(getSearchDataUrl, {'query': searchQuery});

      if(response.statusCode == 200){
        List<SearchDataModel> searchData = [];
        searchData.add(SearchDataModel.fromJson(response.data));

        print('%%%%%%%%%  $searchData');
        return searchData;
      }
    }catch(e){
      throw ApiException('Fail to call search data API');
    }
    return null;
  }
}