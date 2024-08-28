import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/add_comment_repo.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_event.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState>{
  AddCommentBloc() : super(AddCommentInitial()){
    on<AddCommentRequest>(_onAddCommentRequest);
  }
  
  Future<void> _onAddCommentRequest(AddCommentRequest event, Emitter<AddCommentState> emit) async {
    try{
      await AddCommentRepo().addUserComment(event.videoSlug, event.userComment);
      emit(AddCommentSuccess());
    }catch(e){
      emit(AddCommentFailure(error: e.toString()));
    }
  }
  
}