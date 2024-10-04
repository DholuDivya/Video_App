import 'package:equatable/equatable.dart';

abstract class ClearAllHistoryEvent extends Equatable{}

class ClearAllHistoryRequest extends ClearAllHistoryEvent{
  @override
  List<Object?> get props => [];
}