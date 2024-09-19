 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/help_and_support_repo.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_event.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_state.dart';

class HelpAndSupportBloc extends Bloc<HelpAndSupportEvent, HelpAndSupportState>{
  HelpAndSupportBloc() : super(HelpAndSupportInitial()){
    on<HelpAndSupportRequest>(_onHelpAndSupportRequest);
  }

  Future<void> _onHelpAndSupportRequest(HelpAndSupportRequest event, Emitter<HelpAndSupportState> emit) async {
    try{
      final helpAndSupportApiMessage = await HelpAndSupportRepo().helpAndSupport(
          event.userId,
          event.userEmail,
          event.helpMessage
      );
      print('hfugiug');
      emit(HelpAndSupportSuccess(helpAndSupportApiMessage: helpAndSupportApiMessage));
    }catch(e){
      emit(HelpAndSupportFailure(error: e.toString()));
    }
  }
}