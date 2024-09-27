import 'package:equatable/equatable.dart';

import '../../model/settings_api_model.dart';

abstract class SettingsApiState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SettingsApiInitial extends SettingsApiState{}
class SettingsApiLoading extends SettingsApiState{}
class SettingsApiSuccess extends SettingsApiState{
  final List<SettingsApiModel> settingsApiData;

  SettingsApiSuccess({required this.settingsApiData});

  @override
  List<Object?> get props => [settingsApiData];
}

class SettingsApiFailure extends SettingsApiState{
  final String error;

  SettingsApiFailure({required this.error});

  @override
  List<Object?> get props => [error];
}