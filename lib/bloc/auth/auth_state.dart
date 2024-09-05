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

class AuthDeleteUserAccount extends AuthState{
  @override
  List<Object?> get props => [];
}




// STATES FOR REGISTER USER--------------------------------------------------
class RegisterAuthInitial extends AuthState{
  @override
  List<Object?> get props => [];
}

class RegisterAuthLoading extends AuthState{
  @override
  List<Object?> get props => [];
}

class RegisterAuthSuccess extends AuthState{
  @override
  List<Object?> get props => [];
}

class RegisterAuthFailure extends AuthState{
  final String error;

  RegisterAuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}


//  STATES FOR LOGIN EMAIL PASSWORD-----------------------------------------
class LoginAuthInitial extends AuthState{
  @override
  List<Object?> get props => [];
}

class LoginAuthLoading extends AuthState{
  @override
  List<Object?> get props => [];
}

class LoginAuthSuccess extends AuthState{
  final String userToken;

  LoginAuthSuccess({required this.userToken});

  @override
  List<Object?> get props => [userToken];
}

class LoginAuthFailure extends AuthState{
  final String error;

  LoginAuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
