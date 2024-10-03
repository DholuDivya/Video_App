import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/change_app_language/change_app_language_event.dart';
import 'package:vimeo_clone/bloc/change_app_language/change_app_language_state.dart';

import '../../config/global_variable.dart';

class ChangeAppLanguageBloc extends Bloc<ChangeAppLanguageEvent, ChangeAppLanguageState>{
  ChangeAppLanguageBloc() : super(ChangeAppLanguageSuccess(appLanguage: Global.userData?.language ?? 'en')){
    on<ChangeAppLanguageRequest>((event, emit) async {
      await Global.setUserData(
        Global.userData?.userToken,
        Global.userData?.userId,
        Global.userData?.userName,
        Global.userData?.userNumber,
        Global.userData?.userEmail,
        Global.userData?.userProfilePhoto,
        Global.userData?.userChannelId,
        event.appLanguage,
      );
      emit(ChangeAppLanguageSuccess(appLanguage: event.appLanguage));
    });
  }
}





// final userToken = Global.userData!.userToken;
// final userId = Global.userData!.userId;
// final userName = Global.userData!.userName;
// final userNumber = Global.userData!.userNumber;
// final userEmail = Global.userData!.userEmail;
// final userProfilePhoto = Global.userData!.userProfilePhoto;
// final userChannelId = Global.userData!.userChannelId;
// final language = event.appLanguage;
//
// await Global.setUserData(
// userToken,
// userId,
// userName,
// userNumber,
// userEmail,
// userProfilePhoto,
// userChannelId,
// language
// );