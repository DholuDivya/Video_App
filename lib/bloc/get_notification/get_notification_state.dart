import 'package:equatable/equatable.dart';

abstract class GetNotificationState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetNotificationInitial extends GetNotificationState{}

class GetNotificationLoading extends GetNotificationState{}

class GetNotificationLoaded extends GetNotificationState{}

class GetNotificationFailure extends GetNotificationState{
  final String error;

  GetNotificationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}