import 'package:equatable/equatable.dart';

abstract class UserHistoryState extends Equatable{}

class UserHistoryInitial extends UserHistoryState{
  @override
  List<Object?> get props => [];
}

class UserHistoryLoading extends UserHistoryState{
  @override
  List<Object?> get props => [];
}

class UserHistorySuccess extends UserHistoryState{
  @override
  List<Object?> get props => [];
}

class UserHistoryFailure extends UserHistoryState{
  final String error;

  UserHistoryFailure({required this.error});

  @override
  List<Object?> get props => [error];
}