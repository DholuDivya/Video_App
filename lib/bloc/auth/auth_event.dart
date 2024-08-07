import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable{}

// LOGIN WITH EMAIL & PASSWORD ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class LoginWithEmailSubmitted extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailSubmitted({required this.email, required this.password});
  List<Object> get props => [email, password];
}

// LOGIN WITH GOOGLE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class LoginWithGoogleSubmitted extends AuthEvent {
  @override
  List<Object?> get props => [];
}


// NUMBER SUBMITTED ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class SendOtpToPhoneEvent extends AuthEvent{
  final String number;
  // final String name;

  SendOtpToPhoneEvent({required this.number});

  @override
  List<Object?> get props => [number];
}

class OnPhoneOtpSend extends AuthEvent{
  final String verificationId;
  final int? resendToken;

  OnPhoneOtpSend({required this.verificationId, this.resendToken});

  @override
  List<Object?> get props => [verificationId, resendToken];
}

class VerifySentOtp extends AuthEvent{
  final String otpCode;
  final String verificationId;
  // final String name;

  VerifySentOtp({required this.otpCode, required this.verificationId});
  @override
  List<Object?> get props => [otpCode, verificationId];
}


class OnPhoneAuthErrorEvent extends AuthEvent{
  final String error;

  OnPhoneAuthErrorEvent({required this.error});

  @override
  List<Object?> get props => [error];
}


class OnPhoneAuthVerificationCompleted extends AuthEvent{
  final AuthCredential credential;
  // final String name;

  OnPhoneAuthVerificationCompleted({required this.credential});

  @override
  List<Object?> get props => [credential];
}



// REGISTER USER
class OnUserRegisterRequestEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  OnUserRegisterRequestEvent({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];

}


// LOGIN USER
class OnUserLoginRequestEvent extends AuthEvent{
  final String email;
  final String password;

  OnUserLoginRequestEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

}



class OnLogOutRequestEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}



// class LoginWithPhoneNumber extends AuthEvent {
//   final String phoneNumber;
//
//   LoginWithPhoneNumber({required this.phoneNumber});
//   @override
//   List<Object> get props => [phoneNumber];
// }
//
// class VerifyPhoneNumber extends AuthEvent {
//   final String verificationId;
//   final String smsCode;
//
//   VerifyPhoneNumber(this.verificationId, this.smsCode);
//
//   @override
//   List<Object> get props => [verificationId, smsCode];
// }


// OTP CODE SENT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// class LoginPhoneCodeSent extends AuthEvent {
//   final String verificationId;
//   final int resendToken;
//
//   LoginPhoneCodeSent({required this.verificationId, required this.resendToken});
//
//   @override
//   List<Object> get props => [verificationId, resendToken];
// }


// // OTP VERIFICATION COMPLETED ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// class LoginPhoneVerificationCompleted extends AuthEvent {
//   final PhoneAuthCredential credential;
//
//   LoginPhoneVerificationCompleted({required this.credential});
//
//   @override
//   List<Object> get props => [credential];
// }
//
//
// // OTP VERIFICATION FAILED ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// class LoginPhoneVerificationFailed extends AuthEvent {
//   final FirebaseAuthException exception;
//
//   LoginPhoneVerificationFailed({required this.exception});
//
//   @override
//   List<Object> get props => [exception];
// }






// OTP CODE TIMEOUT RETRIEVAL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// class LoginPhoneCodeAutoRetrievalTimeout extends AuthEvent {
//   final String verificationId;
//
//   LoginPhoneCodeAutoRetrievalTimeout({required this.verificationId});
//
//   @override
//   List<Object> get props => [verificationId];
// }


// OTP CODE SUBMITTED ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// class LoginPhoneCodeSubmitted extends AuthEvent {
//   final String verificationId;
//   final String smsCode;
//
//   LoginPhoneCodeSubmitted({required this.verificationId, required this.smsCode});
//
//   @override
//   List<Object> get props => [verificationId, smsCode];
// }







