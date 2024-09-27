import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/settings_api_repo.dart';
import 'package:vimeo_clone/bloc/settings_api/settings_api_event.dart';
import 'package:vimeo_clone/bloc/settings_api/settings_api_state.dart';
import 'package:vimeo_clone/model/settings_api_model.dart';

class SettingsApiBloc extends Bloc<SettingsApiEvent, SettingsApiState>{
  SettingsApiBloc() : super(SettingsApiInitial()){
    on<SettingsApiRequest>(_onSettingsApiRequest);
  }

  Future<void> _onSettingsApiRequest(SettingsApiRequest event, Emitter<SettingsApiState> emit) async {
    try{
      final List<SettingsApiModel>? settingsApiData = await SettingsApiRepo().settingsApi();
      print('SETTINGS ::::::   $settingsApiData');
      emit(SettingsApiSuccess(settingsApiData: settingsApiData!));
    }catch(e){
      emit(SettingsApiFailure(error: e.toString()));
    }
  }
}