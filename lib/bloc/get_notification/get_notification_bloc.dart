import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_notification_repo.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_event.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_state.dart';
import 'package:vimeo_clone/model/get_notification_model.dart';

class GetNotificationBloc extends Bloc<GetNotificationEvent, GetNotificationState>{
  GetNotificationBloc() : super(GetNotificationInitial()){
    on<GetNotificationRequest>(_onGetNotificationRequest);
  }

  Future<void> _onGetNotificationRequest(GetNotificationRequest event, Emitter<GetNotificationState> emit) async {
    try{
      final List<GetNotificationModel>? notificationData = await GetNotificationRepo().getNotification();
      print('From bloc ::==  ${notificationData!.first.message}');
      emit(GetNotificationLoaded(notificationData: notificationData));
    }catch(e){
      emit(GetNotificationFailure(error: e.toString()));
    }
  }
}