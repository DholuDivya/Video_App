import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_state.dart';
import 'package:vimeo_clone/config/global_variable.dart';


import '../../Repo/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginWithGoogleSubmitted>((event, emit) async {
      emit(AuthProgress());
      try {
        String firebaseUserToken = await authRepository.signInWithGoogle();
        String? userToken = await authRepository.verifyToken(firebaseUserToken);
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
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: event.number,
          verificationCompleted: (PhoneAuthCredential credentials) {
            add(OnPhoneAuthVerificationCompleted(credential: credentials));
          },
          verificationFailed: (FirebaseAuthException ex) {
            print('.....==.....Firebase Exception   ${ex}');
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationid, int? resendtoekn) {
            add(OnPhoneOtpSend(
                verificationId: verificationid, resendToken: resendtoekn));
            print('-------------<><><><>${resendtoekn}');
          },
        );
      } catch (e) {
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


        final userToken = await authRepository.verifyToken(firebaseUserToken!);
        print('Firebase Token of Phone Number Login ::: ${firebaseUserToken}');
        print('User Token by Phone Number Login ::: ${userToken}');

        emit(AuthSuccess(userToken!));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });



    // REGISTER USER
    on<OnUserRegisterRequestEvent>((event, emit) async {
      emit(AuthProgress());
      try{
        final userToken = await authRepository.registerUser(
            event.name,
            event.email,
            event.password
        );

        print('User Token after Creating User ::: ${userToken}');

        if (userToken != null) {
          emit(AuthSuccess(userToken));
        } else {
          emit(AuthFailure(error: 'Failed to retrieve token'));
        }

      }catch(e){
        emit(AuthFailure(error: e.toString()));
      }
    });


    // USER LOGIN
    on<OnUserLoginRequestEvent>((event, emit) async {
      emit(AuthProgress());
      try{
        print('${event.email}');
        print('${event.password}');

        final userToken = await authRepository.loginUser(event.email, event.password);
        if(userToken != null){
          emit(AuthSuccess(userToken));
        }else{
          emit(AuthFailure(error: 'Failed to get token'));
        }

      }catch(e){
        emit(AuthFailure(error: e.toString()));
      }
    });



    on<OnLogOutRequestEvent>((event, emit) async {
      emit(AuthProgress());
      try {
        await FirebaseAuth.instance.signOut();
        final box = await Hive.openBox('UserData');
        await box.clear();
        print('Hive Box ************ ${box.values} ************');
        await Global.clearToken();
        print('Token ---- ${Global.token}');
        emit(AuthLogOut());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}

