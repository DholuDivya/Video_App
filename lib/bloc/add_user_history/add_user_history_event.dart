import 'package:equatable/equatable.dart';

abstract class UserHistoryEvent extends Equatable{}

class UserHistoryRequest extends UserHistoryEvent{
  final String lastDuration;
  final String videoSlug;

  UserHistoryRequest({required this.lastDuration, required this.videoSlug});

  @override
  List<Object?> get props => [lastDuration, videoSlug];
}