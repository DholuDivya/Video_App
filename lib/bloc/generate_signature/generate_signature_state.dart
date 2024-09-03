import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/generate_signature_model.dart';

abstract class GenerateSignatureState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GenerateSignatureInitial extends GenerateSignatureState{}

class GenerateSignatureLoading extends GenerateSignatureState{}

class GenerateSignatureSuccess extends GenerateSignatureState{
  final List<GenerateSignatureModel> signatureData;

  GenerateSignatureSuccess({required this.signatureData});

  @override
  List<Object?> get props => [signatureData];
}

class GenerateSignatureFailure extends GenerateSignatureState{
  final String error;

  GenerateSignatureFailure({required this.error});

  @override
  List<Object?> get props => [error];
}