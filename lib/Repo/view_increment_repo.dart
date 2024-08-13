import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';

class ViewIncrementRepo{
  Future<void> viewIncrement(String videoSlug) async {
    try{
      final response = await ApiBaseHelper().postAPICall('${apiUrl}videos/$videoSlug/increment-view', {});
      if(response.statusCode == 200){
        print('VIEW INCREMENTED SUCCESSFULLY');
      }
    }catch(e){
      throw ApiException('Fail to call API of View Increment');
    }
  }
}