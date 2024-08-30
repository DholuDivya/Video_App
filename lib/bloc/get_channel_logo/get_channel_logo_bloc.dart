import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/get_channel_logo/get_channel_logo_event.dart';
import 'package:vimeo_clone/bloc/get_channel_logo/get_channel_logo_state.dart';
import 'package:vimeo_clone/config/colors.dart';

class GetChannelLogoBloc extends Bloc<GetChannelLogoEvent, GetChannelLogoState>{
  GetChannelLogoBloc() : super(GetChannelLogoInitial()){
    on<OpenFilesToGetChannelLogo>(_onOpenFilesToGetChannelLogo);
  }

  Future<void> _onOpenFilesToGetChannelLogo(OpenFilesToGetChannelLogo event, Emitter<GetChannelLogoState> emit) async {
    try {
      // PlatformFile? thumbnail;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.single.path != null) {
        final PlatformFile channelLogo = result.files.first;
        final croppedLogo = await cropImage(channelLogo);
        print('Cropped image path: $croppedLogo');

        emit(GetChannelLogoLoaded(channelLogo: croppedLogo));
      } else {
        emit(GetChannelLogoFailure(error: 'Failed to get image from file'));
      }
    } catch (e) {
      emit(GetChannelLogoFailure(error: e.toString()));
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
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          aspectRatioPresets: [
            // CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio4x3
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          minimumAspectRatio: 4/3,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio4x3,
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