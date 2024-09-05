import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_event.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_state.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:vimeo_clone/config/security.dart';

class EditVideoDetailBloc extends Bloc<EditVideoDetailEvent, EditVideoDetailState>{
  EditVideoDetailBloc() : super(EditVideoDetailInitial()){
    on<EditVideoDetailRequest>(_onEditVideoDetailRequest);
  }

  Future<void> _onEditVideoDetailRequest(EditVideoDetailRequest event, Emitter<EditVideoDetailState> emit) async {
    try{

      FormData formData = FormData.fromMap({
        'thumbnail': await MultipartFile.fromFile(event.videoThumbnail.path),
        'title': event.videoTitle,
        'description': event.videoDescription,
        'visibility': event.videoVisibility,
        'hashtag': event.videoHashtag,
      });

      final response = await Dio().post(editVideoDetailUrl,
          data: formData,
          options: Options(
              headers: headers
          )
      );

      if(response.statusCode == 200){
        print('Video edited successfully');
      }
    }catch(e){
      emit(EditVideoDetailFailure(error: e.toString()));
    }
  }
}