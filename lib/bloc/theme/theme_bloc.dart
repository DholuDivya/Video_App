
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  late int mode = 1;
  ThemeBloc() : super(ThemeMode.system) {
    on<ThemeChanged>((event, emit) {
      _saveTheme(event.themeMode);
      emit(event.themeMode);
    });
    _loadTheme();
  }

  void _saveTheme(ThemeMode theme) {
    final box = Hive.box('themebox');
    box.put('themeMode', theme.index);
    mode = box.get('themeMode');
  }

  void _loadTheme() {
    final box = Hive.box('themebox');
    final themeIndex =
    box.get('themeMode', defaultValue: ThemeMode.system.index);
    emit(ThemeMode.values[themeIndex]);
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vimeo_clone/bloc/theme/theme_event.dart';
//
// class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
//   final Box themeBox;
//
//   ThemeBloc(this.themeBox) : super(ThemeMode.system) {
//     on<ThemeChangeEvent>((event, emit) {
//       emit(event.themeMode);
//       themeBox.put('themeMode', event.themeMode.index);
//     });
//
//     on<ThemeLoadEvent>((event, emit) {
//       final themeIndex = themeBox.get('themeMode', defaultValue: ThemeMode.system.index);
//       final themeMode = ThemeMode.values[themeIndex];
//       emit(themeMode);
//     });
//   }
// }
















// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:vimeo_clone/bloc/theme/theme_event.dart';
// import 'package:vimeo_clone/bloc/theme/theme_state.dart';
//
// class ThemeBloc extends Bloc<ThemeEvent, ThemeMode>{
//   final Box themeBox;
//
//
//   ThemeBloc(this.themeBox) : super(ThemeMode.light){
//    on<ThemeChangeEvent>((event, emit){
//      emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
//      themeBox.put('isDarkMode', event.isDark);
//    });
//
//    on<ThemeLoadEvent>((event, emit) {
//      final isDarkMode = themeBox.get('isDarkMode', defaultValue: false);
//      emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
//    });
//   }
// }