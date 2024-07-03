//
// import 'package:flutter/material.dart';
//
// abstract class ThemeEvent {}
//
// class ThemeChanged extends ThemeEvent {
//   final ThemeMode themeMode;
//
//   ThemeChanged(this.themeMode);
// }
//

















import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable{}

class ThemeChangeEvent extends ThemeEvent{
  final bool isDark;
  ThemeChangeEvent({required this.isDark});
  @override
  // TODO: implement props
  List<Object?> get props => [isDark];
}

class ThemeLoadEvent extends ThemeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}