import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';

class HelpAndSupportRepo{
  Future<dynamic> helpAndSupport(int userId, String userEmail, String helpMessage) async {
    try{
      final response = await ApiBaseHelper().postAPICall(helpAndSupportUrl, {
        'user_id': userId,
        'contact_email': userEmail,
        'help_message': helpMessage
      });

      if(response.statusCode == 201){
        print('HELP AND SUPPORT ::  ${response.data['message']}');
        return response.data['message'];
      }
    }catch(e){
      throw ApiException('Fail to help and support the user');
    }
  }
}