import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_event.dart';

import 'get_video_state.dart';

class GetVideoBloc extends Bloc<GetVideoEvent, GetVideoState>{
  GetVideoBloc() : super(GetVideoInitial()){
    on<OpenFilesToGetVideo>(_openFilesToGetVideo);
  }

  void _openFilesToGetVideo(OpenFilesToGetVideo event, Emitter<GetVideoState> state) async {
    emit(GetVideoLoading());
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video, // Specify that only video files should be picked
      );
      print('||||||||||||    ${result}    |||||||||||||');

      if (result != null) {
        PlatformFile file;
        file = result.files.first;
        print('................   ${file}');

        var box = await Hive.openBox('videoBox'); // Ensure the box is opened before using it
        await box.put('videoPath', file.path); // Use await for asynchronous operation
        print('++++++  ${file.path}');

        // final thumbnailFile = await _generateThumbnail(file.path);


        emit(GetVideoSuccess(userVideo: file));
      } else {
        print('Failed to get video from file');
      }
    }catch(e){
      emit(GetVideoFailure(error: e.toString()));
    }
  }


  // Future<File?> _generateThumbnail(String videoPath) async {
  //   final uint8list = await VideoThumbnail.thumbnailData(
  //     video: videoPath,
  //     imageFormat: ImageFormat.JPEG,
  //     maxWidth: 128, // Adjust as needed
  //     quality: 75,
  //   );
  //
  //   if (uint8list != null) {
  //     final directory = await getTemporaryDirectory();
  //     final thumbnailFile = File('${directory.path}/thumbnail.jpg');
  //     await thumbnailFile.writeAsBytes(uint8list);
  //     return thumbnailFile;
  //   }
  //   return null;
  // }

}