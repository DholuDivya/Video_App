import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/subscribe_channel_repo.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_state.dart';
import 'package:vimeo_clone/model/subscribe_channel_model.dart';

class SubscribeChannelBloc extends Bloc<SubscribeChannelEvent, SubscribeChannelState>{
  SubscribeChannelBloc() : super(SubscribeChannelInitial()){
    on<SubscribeChannelRequest>(_onSubscribeChannelRequest);
    on<UnsubscribeChannelRequest>(_onUnsubscribeChannelRequest);
  }

  Future<void> _onSubscribeChannelRequest(SubscribeChannelRequest event, Emitter<SubscribeChannelState> emit) async {
    try{
      final List<SubscribeChannelModel>? subscribeChannel = await SubscribeChannelRepo().subscribeChannel(event.channelId);
      print('is_subscribed   ::::::::::::::   ${subscribeChannel!.first.isSubscribed}');
      emit(SubscribeChannelSuccess(subscribeChannel: subscribeChannel));
    }catch(e){
      emit(SubscribeChannelFailure(error: e.toString()));
    }
  }

  Future<void> _onUnsubscribeChannelRequest(UnsubscribeChannelRequest event, Emitter<SubscribeChannelState> emit) async {
    try{
      final List<SubscribeChannelModel>? subscribeChannel = await SubscribeChannelRepo().unsubscribeChannel(event.channelId);
      print('is_subscribe   :::::::::::::::   ${subscribeChannel!.first.isSubscribed}');
      emit(UnsubscribeChannelSuccess(subscribeChannel: subscribeChannel));
    }catch(e){
      emit(UnsubscribeChannelFailure(error: e.toString()));
    }
  }

}