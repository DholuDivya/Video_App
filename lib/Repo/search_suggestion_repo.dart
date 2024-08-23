import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/search_suggestion_model.dart';

class SearchSuggestionRepo{
  Future<List<SearchSuggestionModel>?> getSearchSuggestion(String searchQuery) async {
    try{
      final response = await ApiBaseHelper().getAPICall(getSearchSuggestionUrl, {'query': searchQuery});

      if(response.statusCode == 200){
        List<SearchSuggestionModel> searchSuggestionData = [];
        searchSuggestionData.add(SearchSuggestionModel.fromJson(response.data));
        return searchSuggestionData;
      }
    }catch(e){
      throw ApiException('Fail to call search suggestion API');
    }
    return null;
  }
}