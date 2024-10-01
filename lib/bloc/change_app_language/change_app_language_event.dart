import 'package:equatable/equatable.dart';

abstract class ChangeAppLanguageEvent extends Equatable{}

class ChangeAppLanguageRequest extends ChangeAppLanguageEvent{
  final String appLanguage;

  ChangeAppLanguageRequest({required this.appLanguage});

  @override
  List<Object?> get props => [];
}