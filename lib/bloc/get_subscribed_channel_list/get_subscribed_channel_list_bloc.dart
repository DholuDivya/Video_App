import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_subscribed_channel_list_repo.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_state.dart';
import 'package:vimeo_clone/model/get_subscribed_channel_list_model.dart';

class GetSubscribedChannelListBloc extends Bloc<GetSubscribedChannelListEvent, GetSubscribedChannelListState>{
  GetSubscribedChannelListBloc() : super(GetSubscribedChannelListInitial()){
    on<GetSubscribedChannelListRequest>(_onGetAllChannelsRequest);
  }

  Future<void> _onGetAllChannelsRequest(GetSubscribedChannelListRequest event, Emitter<GetSubscribedChannelListState> emit) async {
    emit(GetSubscribedChannelListLoading());
    try{
      final List<GetSubscribedChannelListModel>? channelList = await GetAllChannelsRepo().getAllChannelsList();
      print('@@@@@@@@    $channelList');
      emit(GetSubscribedChannelListLoaded(channelList: channelList!));
    }catch(e){
      emit(GetSubscribedChannelListFailure(error: e.toString()));
    }
  }
}