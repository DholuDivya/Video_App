import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/update_user_repo.dart';
import 'package:vimeo_clone/bloc/update_user/update_user_event.dart';
import 'package:vimeo_clone/bloc/update_user/update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState>{
  UpdateUserBloc() : super(UpdateUserInitial()){
    on<UpdateUserRequest>(_onUpdateUserRequest);
  }

  Future<void> _onUpdateUserRequest(UpdateUserRequest event, Emitter<UpdateUserState> emit) async {
    try{
      await UpdateUserRepo().updateChannelDetail(event.channelName, event.channelLogo, event.channelBanner);
    }catch(e){
      emit(UpdateUserFailure(error: e.toString()));
    }
  }
}