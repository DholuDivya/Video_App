import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/app_privacy_content_repo.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_event.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_state.dart';
import 'package:vimeo_clone/model/app_privacy_content_model.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState>{
  AboutUsBloc() : super(AboutUsInitial()){
    on<AboutUsRequest>(_onAboutUsRequest);
  }

  Future<void> _onAboutUsRequest(AboutUsRequest event, Emitter<AboutUsState> emit) async {
    try{
      final List<AppPrivacyContentModel>? aboutUsLink = await AppPrivacyContentRepo().appPrivacyContentRepo();
      emit(AboutUsSuccess(aboutUsLink: aboutUsLink!));
    }catch(e){
      emit(AboutUsFailure(error: e.toString()));
    }
  }
}