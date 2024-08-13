import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_all_channels_repo.dart';
import 'package:vimeo_clone/bloc/get_all_channels/get_all_channels_event.dart';
import 'package:vimeo_clone/bloc/get_all_channels/get_all_channels_state.dart';
import 'package:vimeo_clone/model/get_all_channels_model.dart';

class GetAllChannelsBloc extends Bloc<GetAllChannelsEvent, GetAllChannelsState>{
  GetAllChannelsBloc() : super(GetAllChannelsInitial()){
    on<GetAllChannelsRequest>(_onGetAllChannelsRequest);
  }

  Future<void> _onGetAllChannelsRequest(GetAllChannelsEvent event, Emitter<GetAllChannelsState> emit) async {
    emit(GetAllChannelsLoading());
    try{
      final List<GetAllChannelsModel>? channelList = await GetAllChannelsRepo().getAllChannelsList();
      print('@@@@@@@@    $channelList');
      emit(GetAllChannelsLoaded(channelList: channelList!));
    }catch(e){
      emit(GetAllChannelsFailure(error: e.toString()));
    }
  }

}