import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/channel_profile_repo.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_event.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/model/get_your_videos_model.dart';

class ChannelProfileBloc extends Bloc<ChannelProfileEvent, ChannelProfileState>{
  ChannelProfileBloc() : super(ChannelProfileInitial()){
    on<GetChannelProfileEvent>(_onGetChannelProfileEvent);
  }

  Future<void> _onGetChannelProfileEvent(GetChannelProfileEvent event, Emitter<ChannelProfileState> emit)async {
    emit(ChannelProfileLoading());
    try{
      final List<GetYourVideosModel>? channelData = await ChannelProfileRepo().getChannelProfile(event.channelId);
      if(channelData != null){
        emit(ChannelProfileLoaded(channelData: channelData));
      }else{
        print('Channel Data is NULL');
      }
    }catch(e){
      emit(ChannelProfileFailure(error: e.toString()));
    }
  }

}