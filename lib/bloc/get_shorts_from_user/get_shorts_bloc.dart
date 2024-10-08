import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pod_player/pod_player.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';

class GetShortsBloc extends Bloc<GetShortsEvent, GetShortsState>{
  GetShortsBloc() : super(GetShortsInitial()){
    on<GetShortsFromCamera>(_onGetShortsFromCamera);
    on<GetShortsFromFile>(_onGetShortsFromFiles);
  }

  Future<void> _onGetShortsFromCamera(GetShortsFromCamera event, Emitter<GetShortsState> emit) async {
    emit(GetShortsLoading());
    try{
      final ImagePicker _picker = ImagePicker();
      // XFile? _videoFile;

      final result = await _picker.pickVideo(
        source: ImageSource.camera,
      );

      if (result != null) {
        XFile userShorts = result;
        print('................   ${userShorts}');

        var box = await Hive.openBox('videoBox'); // Ensure the box is opened before using it
        await box.put('videoPath', userShorts.path); // Use await for asynchronous operation
        print('++++++  ${userShorts.path}');

        // final thumbnailFile = await _generateThumbnail(file.path);


        // emit(GetShortsSuccess(userShorts: userShorts));
      } else {
        print('No video selected from camera.');
      }
    }catch(e){
      emit(GetShortsFailure(error: e.toString()));
    }
  }

  Future<void> _onGetShortsFromFiles(GetShortsFromFile event, Emitter<GetShortsState> emit) async {
    emit(GetShortsLoading());
    try{
      final ImagePicker _picker = ImagePicker();
      XFile? _videoFile;

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video, // Specify that only video files should be picked
      );

      if (result != null) {
        PlatformFile userShorts;
        userShorts = result.files.first;
        print('................   ${userShorts}');

        print('++++++  ${userShorts.path}');


        final videoPlayerController = VideoPlayerController.file(File(userShorts.path!));
        // await videoPlayerController.initialize();
        final videoDuration = videoPlayerController.value.duration;

        if (videoDuration.inMinutes < 2) {
          emit(GetShortsSuccess(userShorts: userShorts));
        }else{
          ToastManager().showToast(
              context: event.context,
              message: 'Video must be less than 2 minutes'
          );
        }


      } else {
        print('No video selected from files.');
      }
    }catch(e){
      emit(GetShortsFailure(error: e.toString()));
    }
  }

}