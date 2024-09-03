import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/plans_model.dart';

abstract class GetPlansState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetPlansInitial extends GetPlansState{}

class GetPlansLoading extends GetPlansState{}

class GetPlansLoaded extends GetPlansState{
  final List<PlansModel> plansList;

  GetPlansLoaded({required this.plansList});

  @override
  List<Object?> get props => [plansList];
}

class GetPlansFailure extends GetPlansState{
  final String error;

  GetPlansFailure({required this.error});

  @override
  List<Object?> get props => [error];
}