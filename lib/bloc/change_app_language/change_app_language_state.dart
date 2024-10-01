import 'package:equatable/equatable.dart';

abstract class ChangeAppLanguageState extends Equatable{}

class ChangeAppLanguageSuccess extends ChangeAppLanguageState{
  final String appLanguage;

  ChangeAppLanguageSuccess({required this.appLanguage});

  @override
  List<Object?> get props => [appLanguage];
}

class ChangeAppLanguageFailure extends ChangeAppLanguageState{
  final String error;

  ChangeAppLanguageFailure({required this.error});

  @override
  List<Object?> get props =>[error];
}