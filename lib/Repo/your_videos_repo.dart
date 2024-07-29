import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';

class YourVideosRepo{
  Future<dynamic> getYourVideos()async{
    try{
      // final response = ApiBaseHelper().postAPICall("${apiUrl}channels/", params)
    }catch(e){
      throw ApiException('Failed to call api of Get Your Videos');
    }
  }
}
