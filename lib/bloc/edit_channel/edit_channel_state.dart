import 'package:equatable/equatable.dart';

abstract class EditChannelState extends Equatable{
  @override
  List<Object?> get props => [];
}

class EditChannelInitial extends EditChannelState{}

class EditChannelLoading extends EditChannelState{}

class EditChannelSuccess extends EditChannelState{}

class EditChannelFailure extends EditChannelState{
  final String error;

  EditChannelFailure({required this.error});

  @override
  List<Object?> get props => [error];
}