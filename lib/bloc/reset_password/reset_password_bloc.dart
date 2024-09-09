import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/reset_password_repo.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_event.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{
  ResetPasswordBloc() : super(ResetPasswordInitial()){
    on<ResetPasswordRequest>(_onResetPasswordRequest);
  }

  Future<void> _onResetPasswordRequest(ResetPasswordRequest event, Emitter<ResetPasswordState> emit) async {
    try{
      await ResetPasswordRepo().resetPassword(event.email, event.newPassword, event.confirmPassword, event.token);
      emit(ResetPasswordSuccess());
    }catch(e){
      emit(ResetPasswordFailure(error: e.toString()));
    }
  }
}