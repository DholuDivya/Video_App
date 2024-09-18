import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_event.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_state.dart';

class TermsAndConditionsBloc extends Bloc<TermsAndConditionsEvent, TermsAndConditionsState>{
  TermsAndConditionsBloc() : super(TermsAndConditionsInitial()){
    on<TermsAndConditionsRequest>(_onTermsAndConditionsRequest);
  }

  Future<void> _onTermsAndConditionsRequest(TermsAndConditionsRequest event, Emitter<TermsAndConditionsState> emit) async {
    try{

    }catch(e){
      emit(TermsAndConditionsFailure(error: e.toString()));
    }
  }
}