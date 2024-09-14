import 'package:equatable/equatable.dart';

abstract class ReportVideoState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ReportVideoInitial extends ReportVideoState{}

class ReportVideoLoading extends ReportVideoState{}

class ReportVideoLoaded extends ReportVideoState{}

class ReportVideoFailure extends ReportVideoState{
  final String error;

  ReportVideoFailure({required this.error});

  @override
  List<Object?> get props => [];
}