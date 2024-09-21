import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_subscribed_channel_list_repo.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_state.dart';
import 'package:vimeo_clone/model/get_subscribed_channel_list_model.dart';

class GetSubscribedChannelListBloc extends Bloc<GetSubscribedChannelListEvent, GetSubscribedChannelListState>{

  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;

  GetSubscribedChannelListBloc() : super(GetSubscribedChannelListInitial()){
    on<GetSubscribedChannelListRequest>(_onGetAllChannelsRequest);
    on<LoadMoreSubscriptionsList>(_onLoadMoreSubscriptionList);
  }

  Future<void> _onGetAllChannelsRequest(GetSubscribedChannelListRequest event, Emitter<GetSubscribedChannelListState> emit) async {

    try{
      List<SubscriptionsListData>? channelList = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> channelVideo = await GetAllChannelsRepo().getAllChannelsList(_limit, _offset);
      channelList = List<SubscriptionsListData>.from(channelVideo['data'].map((data) => SubscriptionsListData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = channelList.length < _limit;

      print('@@@@@@@@    $channelList');
      emit(GetSubscribedChannelListLoaded(channelList: channelList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(GetSubscribedChannelListFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreSubscriptionList(
      LoadMoreSubscriptionsList event, Emitter<GetSubscribedChannelListState> emit) async {
    if (state is GetSubscribedChannelListLoaded && !_hasReachedMax) {
      try {
        print('MaxReachedHase_ $_hasReachedMax');
        List<SubscriptionsListData>? channelList = [];
        final currentState = state as GetSubscribedChannelListLoaded;
        final updatedNotes = List<SubscriptionsListData>.from(currentState.channelList);
        Map<String, dynamic> channelVideo = await GetAllChannelsRepo().getAllChannelsList(_limit, _offset);
        channelList = List<SubscriptionsListData>.from(channelVideo['data'].map((data) => SubscriptionsListData.fromJson(data)));

        _offset += _limit;
        if (channelList.length < _limit) {
          _hasReachedMax = true;
        } else {
          _hasReachedMax = false;
        }

        print('rgsdrhgusdrhsef $_hasReachedMax');
        updatedNotes.addAll(channelList);
        emit(GetSubscribedChannelListLoaded(channelList: updatedNotes, hasReachedMax: _hasReachedMax));
      } catch (e) {
        emit(GetSubscribedChannelListFailure(error: e.toString()));
      }
    }
  }
}