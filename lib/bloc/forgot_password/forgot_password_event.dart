import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable{}

class ForgotPasswordRequest extends ForgotPasswordEvent{
  final String userEmail;

  ForgotPasswordRequest({required this.userEmail});

  @override
  List<Object?> get props => [userEmail];
}