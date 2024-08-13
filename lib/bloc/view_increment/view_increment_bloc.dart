import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/view_increment_repo.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_event.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_state.dart';

class ViewIncrementBloc extends Bloc<ViewIncrementEvent, ViewIncrementState>{
  ViewIncrementBloc() : super(ViewIncrementInitial()){
    on<ViewIncrementRequest>(_onViewIncrementRequest);
  }

  Future<void> _onViewIncrementRequest(ViewIncrementRequest event, Emitter<ViewIncrementState> emit) async {
    try{
      await ViewIncrementRepo().viewIncrement(event.videoSlug);
      emit(ViewIncrementSuccess());
    }catch(e){
      emit(ViewIncrementFailure(error: e.toString()));
    }
  }

}