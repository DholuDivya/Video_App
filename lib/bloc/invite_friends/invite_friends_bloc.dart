import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/invite_friends/invite_friends_event.dart';
import 'package:vimeo_clone/bloc/invite_friends/invite_friends_state.dart';

class InviteFriendsBloc extends Bloc<InviteFriendsEvent, InviteFriendsState>{
  InviteFriendsBloc() : super(InviteFriendsInitial()){
    on<InviteFriendsRequest>(_onInviteFriendsRequest);
  }

  Future<void> _onInviteFriendsRequest(InviteFriendsRequest event, Emitter<InviteFriendsState> emit) async {
    try{

    }catch(e){
      emit(InviteFriendsFailure(error: e.toString()));
    }
  }
}