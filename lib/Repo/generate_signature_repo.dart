import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/model/generate_signature_model.dart';

class GenerateSignatureRepo{
  Future<List<GenerateSignatureModel>?> generateSignature(int planId) async {
    try {
      final response = await ApiBaseHelper().postAPICall(generateSignatureUrl, {'plan_id': planId});
      if(response.statusCode == 200){
        List<GenerateSignatureModel> generateSignature = [];
        generateSignature.add(GenerateSignatureModel.fromJson(response.data));
        print('Signature is generated successfully');
        return generateSignature;
      }
    }catch(e){
     throw ApiException('Fail to call generate signature API');
    }
    return null;
  }
}