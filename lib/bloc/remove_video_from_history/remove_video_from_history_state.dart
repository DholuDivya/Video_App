import 'package:equatable/equatable.dart';

abstract class RemoveVideoFromHistoryState extends Equatable{
  @override
  List<Object?> get props => [];
}

class RemoveVideoFromHistoryInitial extends RemoveVideoFromHistoryState{}

class RemoveVideoFromHistoryLoading extends RemoveVideoFromHistoryState{}

class RemoveVideoFromHistorySuccess extends RemoveVideoFromHistoryState{}

class RemoveVideoFromHistoryFailure extends RemoveVideoFromHistoryState{
  final String error;
  
  RemoveVideoFromHistoryFailure({required this.error});
  
  @override
  List<Object?> get props => [];
}