import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_state.dart';
import 'package:vimeo_clone/config/colors.dart';

class GetShortsThumbnailBloc extends Bloc<GetShortsThumbnailEvent, GetShortsThumbnailState>{
  GetShortsThumbnailBloc() : super(GetShortsThumbnailInitial()) {
    on<GetShortsThumbnailRequest>(_onGetShortsThumbnailRequest);
  }

  Future<void> _onGetShortsThumbnailRequest(GetShortsThumbnailRequest event, Emitter<GetShortsThumbnailState> emit) async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image
      );

      if(result != null && result.files.single.path != null){
        final PlatformFile thumbnail = result.files.first;
        final croppedShortsThumbnail = await cropShortThumbnail(thumbnail);
        print('Cropped thumbnail of shorts: ${croppedShortsThumbnail.path}');
        emit(GetShortsThumbnailSuccess(shortThumbnail: croppedShortsThumbnail));
      }
    }catch(e){
      emit(GetShortsThumbnailFailure(error: e.toString()));
    }
  }


  Future<CroppedFile> cropShortThumbnail(PlatformFile thumbnail) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: thumbnail.path!,
      aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 16),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          // initAspectRatio: CropAspectRatioPreset.ratio16x9,
          aspectRatioPresets: [
            // CropAspectRatioPreset.ratio16x9,
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


}