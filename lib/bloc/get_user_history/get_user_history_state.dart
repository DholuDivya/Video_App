import 'package:equatable/equatable.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/model/user_history_model.dart';

abstract class GetUserHistoryState extends Equatable{}

class GetUserHistoryInitial extends GetUserHistoryState{
  @override
  List<Object?> get props => [];
}

class GetUserHistoryLoading extends GetUserHistoryState{
  @override
  List<Object?> get props => [];
}

class GetUserHistorySuccess extends GetUserHistoryState{
  final List<UserHistoryData> userHistory;
  final bool hasReachedMax;

  GetUserHistorySuccess({required this.userHistory, required this.hasReachedMax});

  @override
  List<Object?> get props => [userHistory, hasReachedMax];
}

class GetUserHistoryFailure extends GetUserHistoryState{
  final String error;

  GetUserHistoryFailure({required this.error});

  @override
  List<Object?> get props => [error];
}