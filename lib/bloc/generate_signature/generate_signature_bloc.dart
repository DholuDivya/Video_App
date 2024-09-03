import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/generate_signature_repo.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_event.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_state.dart';
import 'package:vimeo_clone/model/generate_signature_model.dart';

class GenerateSignatureBloc extends Bloc<GenerateSignatureEvent, GenerateSignatureState>{
  GenerateSignatureBloc() : super(GenerateSignatureInitial()){
    on<GenerateSignatureRequest>(_onGenerateSignatureRequest);
  }

  Future<void> _onGenerateSignatureRequest(GenerateSignatureRequest event, Emitter<GenerateSignatureState> emit) async {
    try{
      final List<GenerateSignatureModel>? signatureData = await GenerateSignatureRepo().generateSignature(event.planId);
      print('ngiklsrgnbrbgnsbnsbbbnob   ${signatureData!.first.orderId}');
      emit(GenerateSignatureSuccess(signatureData: signatureData));
    }catch(e){
      emit(GenerateSignatureFailure(error: e.toString()));
    }
  }
}