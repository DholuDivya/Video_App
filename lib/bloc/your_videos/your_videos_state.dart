import 'package:equatable/equatable.dart';

abstract class YourVideosState extends Equatable{}

class YourVideosInitial extends YourVideosState{
  @override
  List<Object?> get props => [];
}

class YourVideosLoading extends YourVideosState{
  @override
  List<Object?> get props => [];
}

class YourVideosLoaded extends YourVideosState{
  @override
  List<Object?> get props => [];
}

class YourVideosFailure extends YourVideosState{
  final String error;

  YourVideosFailure({required this.error});

  @override
  List<Object?> get props => [error];
}