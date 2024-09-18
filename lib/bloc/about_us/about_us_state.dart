import 'package:equatable/equatable.dart';

abstract class AboutUsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AboutUsInitial extends AboutUsState{}

class AboutUsLoading extends AboutUsState{}

class AboutUsSuccess extends AboutUsState{}

class AboutUsFailure extends AboutUsState{
  final String error;

  AboutUsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}