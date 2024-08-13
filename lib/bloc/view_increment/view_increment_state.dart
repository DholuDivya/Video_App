import 'package:equatable/equatable.dart';

abstract class ViewIncrementState extends Equatable{}

class ViewIncrementInitial extends ViewIncrementState{
  @override
  List<Object?> get props => [];
}

class ViewIncrementLoading extends ViewIncrementState{
  @override
  List<Object?> get props => [];
}

class ViewIncrementSuccess extends ViewIncrementState{
  @override
  List<Object?> get props => [];
}

class ViewIncrementFailure extends ViewIncrementState{
  final String error;

  ViewIncrementFailure({required this.error});

  @override
  List<Object?> get props => [];
}