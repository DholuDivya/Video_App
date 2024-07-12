import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{}

class AuthInitial extends AuthState{
  @override
  List<Object?> get props => [];
}

class AuthProgress extends AuthState{
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState{
  final String userToken;
  AuthSuccess(this.userToken);

  @override
  List<Object?> get props => [];

}

class AuthFailure extends AuthState{
  final String? error;
  AuthFailure({this.error});
  @override
  List<Object?> get props => [];
}

class LoginPhoneCodeSentState extends AuthState {
  final String? verificationId;
  // final int resendToken;
  LoginPhoneCodeSentState({this.verificationId});

  @override
  List<Object> get props => [verificationId!];
}

class AuthLogOut extends AuthState{
  @override
  List<Object?> get props => [];

}