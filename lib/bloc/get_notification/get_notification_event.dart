import 'package:equatable/equatable.dart';

abstract class GetNotificationEvent extends Equatable{}

class GetNotificationRequest extends GetNotificationEvent{
  @override
  List<Object?> get props => [];
}