import 'package:equatable/equatable.dart';

abstract class GetPlansEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetPlansRequest extends GetPlansEvent{}