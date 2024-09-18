import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/privacy_policy/privacy_policy_event.dart';
import 'package:vimeo_clone/bloc/privacy_policy/privacy_policy_state.dart';

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState>{
  PrivacyPolicyBloc() :  super(PrivacyPolicyInitial()){
    on<PrivacyPolicyRequest>(_onPrivacyPolicyRequest);
  }

  Future<void> _onPrivacyPolicyRequest(PrivacyPolicyRequest event, Emitter<PrivacyPolicyState> emit) async {
    try{

    }catch(e){
      emit(PrivacyPolicyFailure(error: e.toString()));
    }
  }
}