import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/forgot_password_repo.dart';
import 'package:vimeo_clone/bloc/forgot_password/forgot_password_event.dart';
import 'package:vimeo_clone/bloc/forgot_password/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState>{
  ForgotPasswordBloc() : super(ForgotPasswordInitial()){
    on<ForgotPasswordRequest>(_onForgotPasswordRequest);
  }

  Future<void> _onForgotPasswordRequest(ForgotPasswordRequest event, Emitter<ForgotPasswordState> emit ) async {
    try{
      await ForgotPasswordRepo().forgotPassword(event.userEmail);
      emit(ForgotPasswordSuccess());
    }catch(e){
      emit(ForgotPasswordFailure(error: e.toString()));
    }
  }
}