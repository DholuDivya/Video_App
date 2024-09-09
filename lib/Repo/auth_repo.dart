import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';

import '../config/notification_service.dart';

class AuthRepository{
  final ApiBaseHelper apiHelper;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(this.apiHelper, {FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email and Password Authentication
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );


  }

  Future<String?> signUpWithEmailAndPassword(String email, String password) async {
    final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    User? user = credential.user;

    if (user != null) {
      String? token = await user.getIdToken();
      print('Firebase Token from Create User With Email and Password::::: $token');
      return token;
    } else {
      print('User is null');
      return null;
    }
  }



  Future<String> signInWithGoogle() async {

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('User cancelled the login');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final IdTokenResult idTokenResult = await user.getIdTokenResult();
        final String? accessToken = idTokenResult.token;
        if (accessToken != null) {
          print('Access Token ~~~~~${accessToken}');
          print('66666666666666666666666666666');
          return accessToken;
        } else {
          throw Exception('Failed to get token');
        }
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to sign in with Google');
    }
  }


  // Phone Number Authentication
  Future<String> verifyPhoneNumber(String phoneNumber) async {
    try {
      Completer<String> completer = Completer<String>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(Exception('Failed to verify phone number: ${e.message}'));
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return completer.future;
    } catch (e) {
      throw Exception('Failed to verify phone number: $e');
    }
  }

  // Future<PhoneAuthCredential> loginWithPhoneNumber(String verificationId, String smsCode) async {
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: smsCode,
  //     );
  //     return credential;
  //     } catch (e) {
  //     throw Exception('Failed to sign in with phone number: $e');
  //   }
  // }


  // VERIFY TOKEN FROM FIREBASE
  Future<String?> loginWithGoogle(String firebaseUserToken) async {
    try{
      final fcmId = await NotificationService().getFcmToken();
      print('FCM ID  ::::  $fcmId');
      final response = await apiHelper.firebaseLoginPostAPICall(loginWithGoogleUrl, {}, firebaseUserToken);

      if (response.statusCode == 200) {
        // STORING THE TOKEN IN HIVE

        print('user token ::::    ${response.data['token']}');
        print('user id ::::    ${response.data['user']['id']}');
        print('user name ::::    ${response.data['user']['name']}');
        print('user phone number ::::    ${response.data['user']['phone_number'] ?? ''}');
        print('user email ::::    ${response.data['user']['email']}');
        print('user profile ::::    ${response.data['user']['profile']}');
        print('channel id ::::    ${response.data['channels'][0]['id']}');

        if(response.data != null){
          final String userToken = response.data['token'] ?? '';
          final String userId = response.data['user']['id'].toString() ?? '';
          final String userName = response.data['user']['name'] ?? '';
          final String userNumber = response.data['user']['phone_number'] ?? '';
          final String userEmail = response.data['user']['email'] ?? '';
          final String userProfilePhoto = response.data['user']['profile'] ?? '';
          final String userChannelId = response.data['channels'][0]['id'].toString() ?? '';
          print('++++++++    ${userToken}'
              '++++++++    ${userId}'
              '++++++++    ${userName}'
              '++++++++    ${userNumber}'
              '++++++++    ${userEmail}'
              '++++++++    ${userProfilePhoto}'
              '++++++++    ${userChannelId}');

          print('88888888888888888888888');
          await Global.setUserData(
            userToken,
            userId,
            userName,
            userNumber,
            userEmail,
            userProfilePhoto,
            userChannelId,
          );
          print('iiiiiiiiiiiiiiiiiiiiiiiiiiiii');
          log('${Global.userData}');
          // RETURN TOKEN
          print('Token Verified Successfully');
          print(':::::::::::::::::::  $userToken   :::::::::::::::::::');
          return userToken;
        }else{
          print('Data Not Found');
        }

      } else {
        throw ApiException('Failed to verify token : ${response.data}');
      }
    }catch(e){
       throw ApiException('Failed to verify token: $e');
    }
    return null;
  }



  Future<String?> loginWithPhone(String firebaseUserToken, String userName) async {
    try{
      final fcmId = await NotificationService().getFcmToken();
      print('FCM ID  ::::  $fcmId');
      print('11111111111111111111111111111111');
      print('MIIIIIIIIIIIIIIIIIII     $userName');
      final response = await apiHelper.firebaseLoginPostAPICall(loginWithPhoneUrl,
          {
            'name': userName,
            'fcm_id': fcmId
          },
          firebaseUserToken
      );
      print('ifgWRHNGOIERGOIRBNIORBIODIDDirdigjirdj');
      if (response.statusCode == 200) {

        // STORING THE TOKEN IN HIVE
        print('uiaejifasEionsiodvisfififibdf');
        print('user token ::::    ${response.data['token']}');
        print('user token ::::    ${response.data['user']['id']}');
        print('user token ::::    ${response.data['user']['name']}');
        print('user token ::::    ${response.data['user']['phone_number']}');
        print('user token ::::    ${response.data['user']['email']}');
        print('user token ::::    ${response.data['user']['profile']}');
        print('user token ::::    ${response.data['channels'][0]['id']}');

        final String userToken = response.data['token'] ?? '';
        final String userId = response.data['user']['id'].toString() ?? '';
        final String userName = response.data['user']['name'] ?? '';
        final String userNumber = response.data['user']['phone_number'] ?? '';
        final String userEmail = response.data['user']['email'] ?? '';
        final String userProfilePhoto = response.data['user']['profile'] ?? '';
        final String userChannelId = response.data['channels'][0]['id'].toString() ?? '';
        print('++++++++    ${userToken}'
            '++++++++    ${userId}'
            '++++++++    ${userName}'
            '++++++++    ${userNumber}'
            '++++++++    ${userEmail}'
            '++++++++    ${userProfilePhoto}'
            '++++++++    ${userChannelId}');

        print('88888888888888888888888');
        await Global.setUserData(
          userToken,
          userId,
          userName,
          userNumber,
          userEmail,
          userProfilePhoto,
          userChannelId,
        );

        print('${Global.userData}');
        // RETURN TOKEN
        print('Token Verified Successfully');
        print(':::::::::::::::::::  $userToken   :::::::::::::::::::');
        return userToken;
      } else {
        throw ApiException('Failed to verify token : ${response.data}');
      }
    }catch(e){
      throw ApiException('Failed to verify token: $e');
    }
  }






  // REGISTER USER
  Future<dynamic> registerUser(String name, String email, String password) async {
    try{
      final response = await apiHelper.registerUserPostAPICall(registerUserUrl, {'name': name, 'email': email, 'password': password} );
      print('&&&&&&&&&&   ${response.data}');
      return response.data['access_token'];
    }catch(e){
      throw ApiException('Failed to Add new User--- $e');
    }
  }




  // LOGIN USER
  Future<dynamic> loginUser(String email, String password) async {
    try{
      final fcmId = await NotificationService().getFcmToken();
      print('FCM ID  ::::  $fcmId');
      print('2000000000000000000');
      final response = await apiHelper.loginUserEmail(loginUserUrl,
          {
            'email': email,
            'password': password,
            'fcm_id': fcmId,
          });
      print('srbgirswugbhuswgbhusrhsbhvjuvjubhvujjuhvujhbd');
      print('${response.data}');
      if(response.statusCode == 200){

        // STORING THE TOKEN IN HIVE ------
        if(response.data != null){
          final String userToken = response.data['data']['token'] ?? '';
          final String userId = response.data['data']['user']['id'].toString() ?? '';
          final String userName = response.data['data']['user']['name'] ?? '';
          final String userNumber = response.data['data']['user']['phone_number'] ?? '';
          final String userEmail = response.data['data']['user']['email'] ?? '';
          final String userProfilePhoto = response.data['data']['user']['profile'] ?? '';
          final String userChannelId = response.data['data']['channel'][0]['id'].toString();
          print('++++++++    ${userToken}'
              '++++++++    ${userId}'
              '++++++++    ${userName}'
              '++++++++    ${userNumber}'
              '++++++++    ${userEmail}'
              '++++++++    ${userProfilePhoto}'
              '++++++++    ${userChannelId}');

          print('88888888888888888888888');
          await Global.setUserData(
            userToken,
            userId,
            userName,
            userNumber,
            userEmail,
            userProfilePhoto,
            userChannelId,
          );
          print('iiiiiiiiiiiiiiiiiiiiiiiiiiiii');
          log('${Global.userData}');
          // RETURN TOKEN
          print('Token Verified Successfully');
          print(':::::::::::::::::::  $userToken   :::::::::::::::::::');

          return userToken;
        }else{
          print('Data Not Found');
        }


        // RETURN TOKEN
        // String userToken = response.data['data']['token'];
        // print('Logged in successfully ${response.data}');
        // print(':::::::::::::::::::  ${userToken}   :::::::::::::::::::');
        // return userToken;
      }else{
        print('Failed to Login');
      }

    }catch(e){
      throw ApiException('Failed to Login User --- $e');
    }
  }
  
  
  Future logOutUser() async {
    print('api call --------');
    try{
      final response = await apiHelper.postAPICall(userLogOutUrl, {});
      print(response.data);
      if(response.statusCode == 200){
        await FirebaseAuth.instance.signOut();
        final box = await Hive.openBox('UserData');
        // await box.clear();
        print('Hive Box ************ ${box.values} ************');
        await Global.clearUserData();
        // print('Token ---- ${Global.token}');
        // print('Token ---- ${Global.userName}');


        print('User Logged Out Successfully');
      }
      else{
        print('Failed to log out user');
      }
    }catch(e){
      throw ApiException('Failed to Log out user ----- $e');
    }
  }


  Future deleteUserAccount(String password) async {
    try{
      final response = await ApiBaseHelper().deleteAPICall(deleteUserAccountUrl, {
        'password': password
      });

      if(response.statusCode == 200){
        await Global.clearUserData();
        print('User account is successfully delete');
      }
    }catch(e){
      throw ApiException('Failed to delete user account ');
    }
  }
}

