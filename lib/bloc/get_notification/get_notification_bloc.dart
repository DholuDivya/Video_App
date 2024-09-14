import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_event.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_state.dart';

class GetNotificationBloc extends Bloc<GetNotificationEvent, GetNotificationState>{
  GetNotificationBloc() : super(GetNotificationInitial()){
    on<GetNotificationRequest>(_onGetNotificationRequest);
  }

  Future<void> _onGetNotificationRequest(GetNotificationRequest event, Emitter<GetNotificationState> emit) async {
    try{

    }catch(e){
      emit(GetNotificationFailure(error: e.toString()));
    }
  }
}