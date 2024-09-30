import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_state.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';


import '../../Repo/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late String userName;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginWithGoogleSubmitted>((event, emit) async {
      emit(AuthProgress());
      try {
        print('%%%%%%%%%     ${Global.userData}');
        String firebaseUserToken = await authRepository.signInWithGoogle();
        // final response = await Dio().post(
        //     '${loginWithGoogleUrl}',
        //     options: Options(
        //       headers: headers
        //     )
        // );
        print('7777777777777777777777       ${firebaseUserToken}');
        String? userToken = await authRepository.loginWithGoogle(firebaseUserToken);
        print('Firebase Token ::: ${firebaseUserToken}');
        print('User Token ::: ${userToken}');
        emit(AuthSuccess(userToken!));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<SendOtpToPhoneEvent>((event, emit) async {
      emit(AuthProgress());
      try {
        userName = event.name;
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: event.number,
          verificationCompleted: (PhoneAuthCredential credentials) {
            add(OnPhoneAuthVerificationCompleted(credential: credentials,));
          },
          verificationFailed: (FirebaseAuthException ex) {
            print('.....==.....Firebase Exception   ${ex}');
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationid, int? resendtoekn) {
            add(OnPhoneOtpSend(
                verificationId: verificationid, resendToken: resendtoekn, name: event.name));
            print('-------------<><><><>${resendtoekn}');
          },
        );
      } catch (e) {
        print('send otp failed');
        emit(AuthFailure(error: e.toString()));
      }
    });


    on<OnPhoneOtpSend>((event, emit) {
          log('^^^^^^^^^^^^^^^^^^^^^^^^');
          emit(LoginPhoneCodeSentState(verificationId: event.verificationId));
        });


    on<VerifySentOtp>((event, emit) {
          emit(AuthProgress());
          try {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: event.verificationId, smsCode: event.otpCode);
            add(OnPhoneAuthVerificationCompleted(credential: credential));
            print('<<<<<<<<<<<<<-------------${credential.token}------access  ${credential.accessToken}');
          } catch (e) {
            print('verify otp failed');
            emit(AuthFailure(error: e.toString()));
          }
        });


    on<OnPhoneAuthVerificationCompleted>((event, emit) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(event.credential);
        final firebaseUserToken = await userCredential.user!.getIdToken(true);
        print(
            '----   ${firebaseUserToken}\n----refreshToken   ${userCredential.user!.refreshToken}  ');

        final userToken = await authRepository.loginWithPhone(firebaseUserToken!, userName);
        print('Firebase Token of Phone Number Login ::: ${firebaseUserToken}');
        print('User Token by Phone Number Login ::: ${userToken}');

        emit(AuthSuccess(userToken!));
      } catch (e) {
        print('verify user failed');
        emit(AuthFailure(error: e.toString()));
      }
    });



    // REGISTER USER
    on<OnUserRegisterRequestEvent>((event, emit) async {
      emit(RegisterAuthLoading());
      try{
        final accessToken = await authRepository.registerUser(
            event.name,
            event.email,
            event.password
        );
        if(accessToken != null){
          emit(RegisterAuthSuccess());
        }
      }catch(e){
        emit(RegisterAuthFailure(error: e.toString()));
      }
    });


    // USER LOGIN
    on<OnUserLoginRequestEvent>((event, emit) async {
      emit(LoginAuthLoading());
      try{
        print('${event.email}');
        print('${event.password}');

        final userToken = await authRepository.loginUser(event.email, event.password);
        if(userToken != null){
          emit(LoginAuthSuccess(userToken: userToken));
        }else{
          emit(LoginAuthFailure(error: 'Failed to get token'));
        }
      }catch(e){
        emit(LoginAuthFailure(error: e.toString()));
      }
    });



    on<OnLogOutRequestEvent>((event, emit) async {
      emit(AuthProgress());
      try {
        await authRepository.logOutUser();
        print('Log out function');
        emit(AuthLogOut());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });



    on<OnDeleteUserAccountRequestEvent>((event, emit) async {
      emit(AuthProgress());
      try{
        await authRepository.deleteUserAccount();
        print('Account deleted successfully');
        emit(AuthDeleteUserAccount());
      }catch(e){
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}

