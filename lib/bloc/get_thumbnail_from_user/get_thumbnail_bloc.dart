import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_state.dart';
import 'package:vimeo_clone/config/colors.dart';

class GetThumbnailBloc extends Bloc<GetThumbnailEvent, GetThumbnailState> {
  GetThumbnailBloc() : super(GetThumbnailInitial()) {
    on<OpenFilesToGetThumbnail>(_openFilesToGetThumbnail);
  }

  void _openFilesToGetThumbnail(
      OpenFilesToGetThumbnail event, Emitter<GetThumbnailState> emit) async {
    emit(GetThumbnailLoading());
    try {
      PlatformFile? thumbnail;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Specify the file type to image
      );

      if (result != null && result.files.single.path != null) {
        final PlatformFile thumbnail = result.files.first;
        final croppedThumbnail = await cropImage(thumbnail);
        print('Cropped image path: $croppedThumbnail');

        emit(GetThumbnailSuccess(videoThumbnail: croppedThumbnail));
      } else {
        emit(GetThumbnailFailure(error: 'Failed to get image from file'));
      }
    } catch (e) {
      emit(GetThumbnailFailure(error: e.toString()));
    }
  }


  Future<CroppedFile> cropImage(PlatformFile thumbnail) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: thumbnail.path!,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio16x9,
            // CropAspectRatioPreset.ratio4x3
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          minimumAspectRatio: 16/9,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio16x9,
            // CropAspectRatioPreset.square,
            // CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        // WebUiSettings(
        //   // context: context,
        // ),
      ],
    );
    return croppedFile!;
  }


}
