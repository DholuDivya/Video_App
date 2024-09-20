import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/shorts_visible/shorts_visible_event.dart';
import 'package:vimeo_clone/bloc/shorts_visible/shorts_visible_state.dart';

class ShortsVisibleBloc extends Bloc<ShortsVisibleEvent, ShortsVisibleState>{
  int? index;
  ShortsVisibleBloc() : super(ShortsVisibleInitial()){
    on<ShortsVisibleRequest>(_onShortsVisibleRequest);
  }

  Future<void> _onShortsVisibleRequest(ShortsVisibleRequest event, Emitter<ShortsVisibleState> emit) async {
    try{
      index = event.index;
      print('dkfnsdikngv');
      emit(ShortsVisibleSuccess(slug: event.slug, shortVisible: event.shortVisible!, index: event.index));
    }catch(e){
      emit(ShortsVisibleFailure(error: e.toString()));
    }
  }
}