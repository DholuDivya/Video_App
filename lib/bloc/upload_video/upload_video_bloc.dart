import 'package:file_picker/src/platform_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:vimeo_clone/Repo/upload_video_repo.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_event.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_state.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';


class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState>{
  UploadVideoBloc() : super(UploadVideoInitial()){
    on<UploadVideoRequestEvent>(_onUploadVideoRequestEvent);
  }

  Future<void> _onUploadVideoRequestEvent(UploadVideoRequestEvent event, Emitter<UploadVideoState> emit)async{

    emit(UploadVideoLoading());
    try{

      print('88888888888888888888888888888888');
      print('lllllllllllllll     ${event.video.path}');
      print('lllllllllllllll     ${event.videoThumbnail}');
      print('lllllllllllllll     ${event.videoCategory.single}');



      String fileName = event.video.path!.split('/').last;
      FormData formData = FormData.fromMap({
        'video': await MultipartFile.fromFile(event.video.path!, filename: fileName),
        'thumbnail': await MultipartFile.fromFile(event.videoThumbnail.path),
        'title': event.videoTitle,
        'description': event.videoDescription,
        'categories[]': event.videoCategory,
        'visibility': event.videoVisibility,
      });
      // final String? token = Global.token;
      // print('************   ${formData}');
      // final response = await UploadVideoRepo().uploadVideo(formData);
      final response = await Dio().post('https://videoapp.taskhub.company/api/video',
        data: formData,
        options: Options(
          headers: headers
        )
      );

      print('99999999999999999999999       ${response} 99999999999999999999999       ${response.statusCode}');
      if(response.data != null){
        print('Video Uploaded Successfully');

        emit(UploadVideoSuccess());
      }else{
        print('Fail to Success');
      }

    }catch(e){
      emit(UploadVideoFailure(error: e.toString()));
    }
  }

}