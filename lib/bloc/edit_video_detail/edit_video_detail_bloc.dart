import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
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



      CroppedFile? videoThumbnail = event.videoThumbnail;
      String? videoThumbnailPath = videoThumbnail?.path;

      print('MMMMMMMMMMM     ::::     ${event.videoThumbnail}');
      print('MMMMMMMMMMM     ::::     ${event.videoTitle}');
      print('MMMMMMMMMMM     ::::     ${event.videoDescription}');
      print('MMMMMMMMMMM     ::::     ${event.videoHashtag}');
      print('MMMMMMMMMMM     ::::     ${event.videoVisibility}');

      FormData formData = FormData.fromMap({
        'thumbnails': videoThumbnailPath != null && videoThumbnailPath.isNotEmpty
            ? await MultipartFile.fromFile(videoThumbnailPath)
            : MultipartFile.fromString(''),
        'title': event.videoTitle,
        'description': event.videoDescription,
        'visibility': event.videoVisibility,
        'hashtag': event.videoHashtag,
      });

      print('uiuiuiuiuiuiui');
      final response = await Dio().post('$editVideoDetailUrl${event.videoSlug}',
          data: formData,
          options: Options(
              headers: headers
          )
      );

      print('${response.data}');
      if(response.statusCode == 200){
        print('Video edited successfully');
        emit(EditVideoDetailSuccess());
      }
    }catch(e){
      emit(EditVideoDetailFailure(error: e.toString()));
    }
  }
}