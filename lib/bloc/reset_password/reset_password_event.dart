import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable{}

class ResetPasswordRequest extends ResetPasswordEvent{
  final String email;
  final String newPassword;
  final String confirmPassword;
  final String token;

  ResetPasswordRequest({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
    required this.token
  });

  @override
  List<Object?> get props => [
    email, newPassword, confirmPassword, token
  ];
}