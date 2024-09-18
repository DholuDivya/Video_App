import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/upload_shorts/upload_shorts_event.dart';
import 'package:vimeo_clone/bloc/upload_shorts/upload_shorts_state.dart';
import 'package:dio/dio.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/security.dart';

class UploadShortsBloc extends Bloc<UploadShortsEvent, UploadShortsState>{
  UploadShortsBloc() : super(UploadShortsInitial()){
    on<UploadShortsRequest>(_onUploadShortsRequest);
  }

  Future<void> _onUploadShortsRequest(UploadShortsRequest event, Emitter<UploadShortsState> emit) async {
    try{
      String fileName = event.video.path!.split('/').last;
      FormData formData = FormData.fromMap({
        'video': await MultipartFile.fromFile(event.video.path!, filename: fileName),
        'thumbnail': await MultipartFile.fromFile(event.videoThumbnail.path),
        'title': event.videoTitle,
        'description': event.videoDescription,
        'categories[]': event.videoCategory,
        'hashtag': event.videoHashtag,
        'visibility': event.videoVisibility,
        'status': 'published'
      });

      final response = await Dio().post('${apiUrl}shorts',
          data: formData,
          options: Options(
              headers: headers
          )
      );

      print('99999999999999999999999       $response 99999999999999999999999       ${response.statusCode}');
      if(response.data != null){
        print('Shorts Uploaded Successfully');

        emit(UploadShortsSuccess());
      }else{
        print('Fail to Success');
      }

    }catch(e){
      emit(UploadShortsFailure(error: e.toString()));
    }
  }
}