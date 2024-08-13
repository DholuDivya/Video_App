import 'package:equatable/equatable.dart';

abstract class GetUserHistoryEvent extends Equatable{}

class GetUserHistoryRequest extends GetUserHistoryEvent{
  @override
  List<Object?> get props => [];
}