import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class ResetPasswordRepo{
  Future<dynamic> resetPassword(
      String email, String newPassword, String confirmPassword, String token) async {
    try{
      final response = await ApiBaseHelper().forgotPasswordAPICall(resetPasswordUrl, {
        'email': email,
        'password': newPassword,
        'password_confirmation': confirmPassword,
        'token': token
      });
      
      if(response.statusCode == 200){
        print('Password changed successfully');
      }
    }catch(e){
      throw ApiException('Fail to call reset password API');
    }
  }
}