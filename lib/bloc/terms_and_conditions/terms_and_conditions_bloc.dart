import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/app_privacy_content_repo.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_event.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_state.dart';
import 'package:vimeo_clone/model/app_privacy_content_model.dart';

class TermsAndConditionsBloc extends Bloc<TermsAndConditionsEvent, TermsAndConditionsState>{
  TermsAndConditionsBloc() : super(TermsAndConditionsInitial()){
    on<TermsAndConditionsRequest>(_onTermsAndConditionsRequest);
  }

  Future<void> _onTermsAndConditionsRequest(TermsAndConditionsRequest event, Emitter<TermsAndConditionsState> emit) async {
    try{
      final List<AppPrivacyContentModel>? termAndConditionLink = await AppPrivacyContentRepo().appPrivacyContentRepo();
      emit(TermsAndConditionsSuccess(termsAndConditionLink: termAndConditionLink!));
    }catch(e){
      emit(TermsAndConditionsFailure(error: e.toString()));
    }
  }
}