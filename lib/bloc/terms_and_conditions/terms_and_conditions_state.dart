import 'package:equatable/equatable.dart';

abstract class TermsAndConditionsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TermsAndConditionsInitial extends TermsAndConditionsState{}

class TermsAndConditionsLoading extends TermsAndConditionsState{}

class TermsAndConditionsSuccess extends TermsAndConditionsState{}

class TermsAndConditionsFailure extends TermsAndConditionsState{
  final String error;

  TermsAndConditionsFailure({required this.error});

  @override
  List<Object?> get props => [];
}