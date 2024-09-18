import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vimeo_clone/model/get_notification_model.dart';

abstract class GetNotificationState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetNotificationInitial extends GetNotificationState{}

class GetNotificationLoading extends GetNotificationState{}

class GetNotificationLoaded extends GetNotificationState{
  final List<GetNotificationModel> notificationData;

  GetNotificationLoaded({required this.notificationData});

  @override
  List<Object?> get props => [notificationData];
}

class GetNotificationFailure extends GetNotificationState{
  final String error;

  GetNotificationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}