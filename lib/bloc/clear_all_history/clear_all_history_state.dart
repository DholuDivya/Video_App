import 'package:equatable/equatable.dart';

abstract class ClearAllHistoryState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ClearAllHistoryInitial extends ClearAllHistoryState{}

class ClearAllHistoryLoading extends ClearAllHistoryState{}

class ClearAllHistorySuccess extends ClearAllHistoryState{
  final String message;

  ClearAllHistorySuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ClearAllHistoryFailure extends ClearAllHistoryState{
  final String error;

  ClearAllHistoryFailure({required this.error});

  @override
  List<Object?> get props => [error];
}