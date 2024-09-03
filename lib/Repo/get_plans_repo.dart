import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/plans_model.dart';

class GetPlansRepo{
  Future<List<PlansModel>?> getPlans() async {
    try{
      final response = await ApiBaseHelper().getAPICall(getPlansUrl, {});
      if(response.statusCode == 200){
        List<PlansModel> plansData = [];
        plansData.add(PlansModel.fromJson(response.data));
        print('Plans fetched successfully');
        return plansData;
      }
    }catch(e){
      throw ApiException('Fail to call get plans API');
    }
    return null;
  }
}