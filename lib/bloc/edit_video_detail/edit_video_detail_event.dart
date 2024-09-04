import 'package:equatable/equatable.dart';

abstract class EditVideoDetailEvent extends Equatable{}

class EditVideoDetailRequest extends EditVideoDetailEvent{
  @override
  List<Object?> get props => throw [];
}