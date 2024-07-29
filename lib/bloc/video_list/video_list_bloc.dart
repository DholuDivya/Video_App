import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/video_list_repo.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_event.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_state.dart';
import 'package:vimeo_clone/model/video_list_model.dart';

import '../../model/all_video_list_model.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState>{
  final VideoListRepo videoListRepo;

  VideoListBloc(this.videoListRepo) : super(VideoListInitial()) {
    on<GetVideoListEvent>(_onGetVideoListEvent);
    // on<GetAllVideoList>(_onGetAllVideoList);
  }

  Future<void> _onGetVideoListEvent(GetVideoListEvent event, Emitter<VideoListState> emit) async {
    emit(VideoListLoading());
    print('Fetching video list for category ID: ${event.categoryId}');
    try {
      final List<Videos>? videoList = await videoListRepo.getVideoList(event.categoryId);
      print('Fetched video list: $videoList');
      emit(VideoListLoaded(videoList: videoList!));
    } catch (e) {
      print('Error fetching video list: $e');
      emit(VideoListFailure(error: e.toString()));
    }
  }

}