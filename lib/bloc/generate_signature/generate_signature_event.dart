import 'package:equatable/equatable.dart';

abstract class GenerateSignatureEvent extends Equatable{}

class GenerateSignatureRequest extends GenerateSignatureEvent{
  final int planId;

  GenerateSignatureRequest({required this.planId});

  @override
  List<Object?> get props => [];
}