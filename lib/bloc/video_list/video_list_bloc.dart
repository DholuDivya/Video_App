import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/video_list_repo.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_event.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_state.dart';
import 'package:vimeo_clone/model/video_list_model.dart';

import '../../model/all_video_list_model.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState>{
  final VideoListRepo videoListRepo;
  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;
  int category = 0;

  VideoListBloc(this.videoListRepo) : super(VideoListInitial()) {
    on<GetVideoListEvent>(_onGetVideoListEvent);
    on<LoadMoreVideoListCategory>(_onLoadMoreVideoListCategory);
  }

  Future<void> _onGetVideoListEvent(GetVideoListEvent event, Emitter<VideoListState> emit) async {
    emit(VideoListLoading());
    print('Fetching video list for category ID: ${event.categoryId}');
    category = event.categoryId;
    try {
      List<Videos>? videoList = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> videoData = await videoListRepo.getVideoList(event.categoryId, _limit, _offset);
      if (videoData['category']['videos'] != null) {
        videoList = List<Videos>.from(videoData['category']['videos'].map((data) => Videos.fromJson(data)));
      } else {
        videoList = [];
        print('No videos available');
      }
      _offset += _limit;
      _hasReachedMax = videoList.length < _limit;
      print('_haseReachedMax $_hasReachedMax');

      print('Fetched video list: $videoList');
      emit(VideoListLoaded(videoList: videoList, hasReachedMax: _hasReachedMax));
    } catch (e) {
      print('Error fetching video list: $e');
      emit(VideoListFailure(error: e.toString()));
    }
  }



  Future<void> _onLoadMoreVideoListCategory(
      LoadMoreVideoListCategory event, Emitter<VideoListState> emit) async {
    if (state is VideoListLoaded && !_hasReachedMax) {
      try {
        List<Videos>? videoList = [];
        final currentState = state as VideoListLoaded;
        final updatedNotes = List<Videos>.from(currentState.videoList);
        print('uiuiiuiuiuiuiui    $category');
        Map<String, dynamic> videoData = await videoListRepo.getVideoList(category, _limit, _offset);
        print('8yyyyuyuu     ${videoData['category']['videos']}');
        videoList = List<Videos>.from(videoData['category']['videos'].map((data) => Videos.fromJson(data)));

        _offset += _limit;
        if(videoList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }

        updatedNotes.addAll(videoList);
        emit(VideoListLoaded(videoList: updatedNotes, hasReachedMax: _hasReachedMax));
      } catch(e){
        emit(VideoListFailure(error: 'ERROR :: ${e.toString()}'));
      }
    }
  }


}