


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
  String? previousThumbnailPath;

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
        // thumbnail = result.files.first;
        // final thumbnailPath = thumbnail.path;
        final PlatformFile thumbnail = result.files.first;
        // Convert the image to 16:9 aspect ratio
        final croppedThumbnail = await cropImage(thumbnail);
        // Create PlatformFile from converted File
        // Print the image path to the console
        print('Image path to be stored in database: ${croppedThumbnail}');

        emit(GetThumbnailSuccess(videoThumbnail: croppedThumbnail));
        // previousThumbnailPath = .path;
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


  // Future<File> _convertToAspectRatio(String imagePath, double aspectRatio) async {
  //   // Load the image
  //   final image = img.decodeImage(File(imagePath).readAsBytesSync())!;
  //
  //   // Calculate new dimensions
  //   int width = image.width;
  //   int height = (width / aspectRatio).round();
  //
  //   if (height > image.height) {
  //     height = image.height;
  //     width = (height * aspectRatio).round();
  //   }
  //
  //   // Resize the image
  //   final resizedImage = img.copyResize(image, width: width, height: height);
  //
  //   // Save the converted image to a temporary file
  //   final directory = Directory.systemTemp;
  //   final thumbnailPath = '${directory.path}/thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //   final thumbnailFile = File(thumbnailPath);
  //   thumbnailFile.writeAsBytesSync(img.encodeJpg(resizedImage));
  //
  //   return thumbnailFile;
  // }


}
