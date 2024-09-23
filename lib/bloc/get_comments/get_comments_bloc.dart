import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_comments_repo.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_state.dart';
import 'package:vimeo_clone/model/get_comments_model.dart';

class GetCommentsBloc extends Bloc<GetCommentsEvent, GetCommentsState>{

  int _offset = 0;
  final int _limit = 5;
  bool _hasReachedMax = false;
  String slug = '';

  GetCommentsBloc() : super(GetCommentsInitial()){
    on<GetCommentsRequest>(_onGetCommentsRequest);
    on<LoadMoreGetComments>(_onLoadMoreGetComments);
  }

  Future<void> _onGetCommentsRequest(GetCommentsRequest event, Emitter<GetCommentsState> emit) async {
    try{
      List<CommentData> getCommentsList = [];
      _offset = 0;
      _hasReachedMax = false;
      slug = event.videoSlug;
      Map<String, dynamic> comment = await GetCommentsRepo().getComments(event.videoSlug, _limit, _offset);
      getCommentsList = List<CommentData>.from(comment['data'].map((data) => CommentData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = getCommentsList.length < _limit;
      emit(GetCommentsLoaded(getCommentsList: getCommentsList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(GetCommentsFailure(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreGetComments(LoadMoreGetComments event, Emitter<GetCommentsState> emit) async {
    if (state is GetCommentsLoaded && !_hasReachedMax) {
      try {
        List<CommentData> getCommentsList = [];
        final currentState = state as GetCommentsLoaded;
        final updatedCommentList = List<CommentData>.from(currentState.getCommentsList);
        Map<String, dynamic> comment = await GetCommentsRepo().getComments(slug, _limit, _offset);
        getCommentsList = List<CommentData>.from(comment['data'].map((data) => CommentData.fromJson(data)));
        _offset += _limit;
        if(getCommentsList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        updatedCommentList.addAll(getCommentsList);
        emit(GetCommentsLoaded(getCommentsList: updatedCommentList, hasReachedMax: _hasReachedMax));
      }catch(e){
        emit(GetCommentsFailure(error: e.toString()));
      }
    }
  }

}