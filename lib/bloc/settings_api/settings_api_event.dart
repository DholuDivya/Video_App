import 'package:equatable/equatable.dart';

abstract class SettingsApiEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SettingsApiRequest extends SettingsApiEvent{}