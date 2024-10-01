import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/change_app_language/change_app_language_event.dart';
import 'package:vimeo_clone/bloc/change_app_language/change_app_language_state.dart';
import 'package:vimeo_clone/config/global_variable.dart';

class ChangeAppLanguageBloc extends Bloc<ChangeAppLanguageEvent, ChangeAppLanguageState>{
  ChangeAppLanguageBloc() : super(ChangeAppLanguageSuccess(appLanguage: 'en')){
    on<ChangeAppLanguageRequest>((event, emit){
      emit(ChangeAppLanguageSuccess(appLanguage: event.appLanguage));
    });
  }
}