import 'package:equatable/equatable.dart';

abstract class HelpAndSupportState extends Equatable{
  @override
  List<Object?> get props => [];
}

class HelpAndSupportInitial extends HelpAndSupportState{}

class HelpAndSupportLoading extends HelpAndSupportState{}

class HelpAndSupportSuccess extends HelpAndSupportState{
  final String helpAndSupportApiMessage;

  HelpAndSupportSuccess({required this.helpAndSupportApiMessage});

  @override
  List<Object?> get props => [helpAndSupportApiMessage];
}

class HelpAndSupportFailure extends HelpAndSupportState{
  final String error;

  HelpAndSupportFailure({required this.error});

  @override
  List<Object?> get props => [error];
}