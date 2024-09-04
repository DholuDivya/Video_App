import 'package:equatable/equatable.dart';

abstract class EditVideoDetailState extends Equatable{
  @override
  List<Object?> get props => [];
}

class EditVideoDetailInitial extends EditVideoDetailState{}

class EditVideoDetailLoading extends EditVideoDetailState{}

class EditVideoDetailSuccess extends EditVideoDetailState{}

class EditVideoDetailFailure extends EditVideoDetailState{
  final String error;

  EditVideoDetailFailure({required this.error});

  @override
  List<Object?> get props => [error];
}