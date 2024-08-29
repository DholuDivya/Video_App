import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/update_user/update_user_event.dart';
import 'package:vimeo_clone/bloc/update_user/update_user_state.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:dio/dio.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState>{
  UpdateUserBloc() : super(UpdateUserInitial()){
    on<UpdateUserRequest>(_onUpdateUserRequest);
  }

  Future<void> _onUpdateUserRequest(UpdateUserRequest event, Emitter<UpdateUserState> emit) async {
    try{

      // String fileName = event.video.path!.split('/').last;

      // FormData formData = FormData.fromMap({
      //   'video': await MultipartFile.fromFile(event.video.path!, filename: fileName),
      //   'thumbnail': await MultipartFile.fromFile(event.videoThumbnail.path),
      //   'title': event.videoTitle,
      //   'description': event.videoDescription,
      //   'categories[]': event.videoCategory,
      //   'visibility': event.videoVisibility,
      // });

      // final response = await Dio().post('https://videoapp.taskhub.company/api/video',
      //     data: formData,
      //     options: Options(
      //         headers: headers
      //     )
      // );

      // if(response.statusCode == 200){
      //   print('Channel data is successfully updated');
      // }
    }catch(e){
      emit(UpdateUserFailure(error: e.toString()));
    }
  }
}