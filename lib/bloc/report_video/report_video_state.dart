import 'package:equatable/equatable.dart';

abstract class ReportVideoState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ReportVideoInitial extends ReportVideoState{}

class ReportVideoLoading extends ReportVideoState{}

class ReportVideoSuccess extends ReportVideoState{
  final String reportApiMessage;

  ReportVideoSuccess({required this.reportApiMessage});

  @override
  List<Object?> get props => [reportApiMessage];
}

class ReportVideoFailure extends ReportVideoState{
  final String error;

  ReportVideoFailure({required this.error});

  @override
  List<Object?> get props => [];
}