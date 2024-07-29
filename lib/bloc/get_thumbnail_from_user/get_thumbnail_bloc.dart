import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_state.dart';

import '../get_video_from_user/get_video_state.dart';

class GetThumbnailBloc extends Bloc<GetThumbnailEvent, GetThumbnailState>{
  String? previousThumbnailPath;
  GetThumbnailBloc() : super(GetThumbnailInitial()){
    on<OpenFilesToGetThumbnail>(_openFilesToGetThumbnail);
  }

  void _openFilesToGetThumbnail(OpenFilesToGetThumbnail event, Emitter<GetThumbnailState> emit) async {


    emit(GetThumbnailLoading());
    try {
      PlatformFile? thumbnail;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Specify the file type to image
      );
      // thumbnail = File(result!.files.single.path!);

      if (result != null && result.files.single.path != null) {
          thumbnail = result.files.first;
        // Print the image path to the console
        print('Image path to be stored in database: ${thumbnail.path}');


        emit(GetThumbnailSuccess(videoThumbnail: thumbnail));
        previousThumbnailPath = thumbnail.path;
      } else {
        emit(GetThumbnailFailure(error: 'Failed to get image from file'));
      }
    } catch (e) {
      emit(GetThumbnailFailure(error: e.toString()));
    }
  }

}