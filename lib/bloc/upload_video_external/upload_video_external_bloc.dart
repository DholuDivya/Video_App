import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_event.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:dio/dio.dart';
import 'package:vimeo_clone/config/security.dart';

class UploadVideoExternalBloc extends Bloc<UploadVideoExternalEvent, UploadVideoExternalState>{
  UploadVideoExternalBloc() : super(UploadVideoExternalInitial()){
    on<UploadVideoExternalRequest>(_onUploadVideoExternalRequest);
  }

  Future<void> _onUploadVideoExternalRequest(UploadVideoExternalRequest event, Emitter<UploadVideoExternalState> emit)async{
    emit(UploadVideoExternalLoading());
    try{
      print('8788788778788787887887787');
      print('${event.videoExternalUrl}');
      print('${event.videoThumbnail.path}');
      print('${event.videoCategory}');
      print('${event.videoTitle}');
      // String fileName = event.video.path!.split('/').last;
      FormData formData = FormData.fromMap({
        'video_url': event.videoExternalUrl,
        'thumbnail': await MultipartFile.fromFile(event.videoThumbnail.path!),
        'title': event.videoTitle,
        'description': event.videoDescription,
        'categories[]': event.videoCategory,
        'visibility': event.videoVisibility,
      });
      print('$formData');
      final response = await Dio().post('${apiUrl}store-external',
          data: formData,
          options: Options(
              headers: headers
          )
      );

      print('99999999999999999999999       ${response.data} 99999999999999999999999       ${response.statusCode}');
      if(response.data != null){
        print('Video Uploaded Successfully');

        emit(UploadVideoExternalSuccess());
      }else{
        print('Fail to Success');
      }
    }catch(e){
      emit(UploadVideoExternalFailure(error: e.toString()));
    }
  }

}