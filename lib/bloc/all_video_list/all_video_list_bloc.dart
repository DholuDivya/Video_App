import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/all_video_list_repo.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_state.dart';

import '../../model/all_video_list_model.dart';

class AllVideoListBloc extends Bloc<AllVideoListEvent, AllVideoListState>{

  AllVideoListBloc() : super(AllVideoListInitial()){
    on<GetAllVideoListEvent>(_onGetAllVideoListEvent);
  }

  Future<void> _onGetAllVideoListEvent(GetAllVideoListEvent event, Emitter<AllVideoListState> emit) async {
    emit(AllVideoListLoading());

    try{
      final List<VideoData>? videoList = await AllVideoListRepo().getAllVideoList();
      print('++++++++  ${videoList}');
      emit(AllVideoListLoaded(videoList: videoList!));
    }catch(e){
      emit(AllVideoListFailure(error: e.toString()));
    }
  }


}