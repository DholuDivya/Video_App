import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_comments_repo.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_state.dart';
import 'package:vimeo_clone/model/get_comments_model.dart';

class GetCommentsBloc extends Bloc<GetCommentsEvent, GetCommentsState>{
  GetCommentsBloc() : super(GetCommentsInitial()){
    on<GetCommentsRequest>(_onGetCommentsRequest);
  }

  Future<void> _onGetCommentsRequest(GetCommentsRequest event, Emitter<GetCommentsState> emit) async {
    try{
      final List<GetCommentsModel>? getCommentsList = await GetCommentsRepo().getComments(event.videoSlug);
      log('CCCOOOMMMEEENNNTTTSSS   :::   $getCommentsList');
      emit(GetCommentsLoaded(getCommentsList: getCommentsList!));
    }catch(e){
      emit(GetCommentsFailure(error: e.toString()));
    }
  }

}