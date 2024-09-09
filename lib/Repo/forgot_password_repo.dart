import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class ForgotPasswordRepo{
  Future<dynamic> forgotPassword(String userEmail) async {
    try{
      final response = await ApiBaseHelper().forgotPasswordAPICall(forgotPasswordUrl,
          {'email': userEmail}
      );
      
      if(response.statusCode == 200){
        print('${response.data['message']}');
      }
    }catch(e){
      throw ApiException('Fail to call forgot password API');
    }
  }
}