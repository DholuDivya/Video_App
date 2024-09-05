import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/bloc/edit_channel/edit_channel_event.dart';
import 'package:vimeo_clone/bloc/edit_channel/edit_channel_state.dart';
import 'package:dio/dio.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';

class EditChannelBloc extends Bloc<EditChannelEvent, EditChannelState>{
  EditChannelBloc() : super(EditChannelInitial()){
    on<EditChannelRequest>(_onUpdateUserRequest);
  }

  Future<void> _onUpdateUserRequest(EditChannelRequest event, Emitter<EditChannelState> emit) async {
    try{

      print('KKKKKKKKKKKKKK      ${event.channelName}');
      print('KKKKKKKKKKKKKK      ${event.channelLogo}');
      print('KKKKKKKKKKKKKK      ${event.channelBanner}');

      FormData formData;

      // if(event.channelName!.isEmpty){
      //   print('iiiiiiiiii');
      //   formData = FormData.fromMap({
      //     // 'name': event.channelName,
      //     'logo': await MultipartFile.fromFile(event.channelLogo!.path),
      //     // 'banner': await MultipartFile.fromFile(event.channelBanner!.path),
      //   });
      // }else if(event.channelLogo!.path.isNotEmpty){
      //   print('ppppppppppp');
      //   formData = FormData.fromMap({
      //     'name': event.channelName,
      //     // 'logo': await MultipartFile.fromFile(event.channelLogo!.path),
      //     // 'banner': await MultipartFile.fromFile(event.channelBanner!.path),
      //   });
      // }else{
      //   print('4444444444444');
      //   formData = FormData.fromMap({
      //     // 'name': event.channelName,
      //     // 'logo': await MultipartFile.fromFile(event.channelLogo!.path),
      //     // 'banner': await MultipartFile.fromFile(event.channelBanner!.path),
      //   });
      // }

      formData = FormData.fromMap({
        'name': event.channelName,
        // 'logo': await MultipartFile.fromFile(event.channelLogo!.path),
        // 'banner': await MultipartFile.fromFile(event.channelBanner!.path),
      });



      final response = await Dio().post('$editChannelUrl${Global.userData!.userChannelId}',
          data: formData,
          options: Options(
              headers: headers
          )
      );
      print('dkvnsfbvnsjbnsbnnjkbndbndkljnbd');
      if(response.data != null){

        print('Updated user name ::::::         ${response.data['channel']['name']}');
        print('Updated user profile :::::        ${response.data['channel']['logo']}');
        print('Updated user banner :::::        ${response.data['channel']['banner_image']}');


        String userNumber;
        final String userToken = Global.userData!.userToken!;
        print('1  :::   $userToken');
        final String userId = Global.userData!.userId!;
        print('2  :::   $userId');
        final String userName = response.data['channel']['name'] ?? Global.userData!.userName!;
        print('3  :::   $userName');
        if(Global.userData!.userNumber!.isEmpty){
          userNumber = '';
        }else{
          userNumber = Global.userData!.userNumber! ?? '';
        }
        final String userEmail = Global.userData!.userEmail!;
        print('5  :::   $userEmail');
        final String userProfilePhoto = response.data['channel']['logo'];
        print('6  :::   $userProfilePhoto');
        final String userChannelId = Global.userData!.userChannelId!;
        print('7  :::   $userChannelId');

        await Global.setUserData(
          userToken,
          userId,
          userName,
          userNumber,
          userEmail,
          userProfilePhoto,
          userChannelId,
        );

        print('^v^v^v^v^v^v^v^v^v^v    ::::   ${Global.userData!.userName}');

        print('Channel data is successfully updated');
        print('${response.data}');
        emit(EditChannelSuccess());
      }else{
        print('Fail to success');
      }
    }catch(e){
      emit(EditChannelFailure(error: e.toString()));
    }
  }
}