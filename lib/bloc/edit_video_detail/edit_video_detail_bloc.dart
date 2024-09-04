import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_event.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_state.dart';

class EditVideoDetailBloc extends Bloc<EditVideoDetailEvent, EditVideoDetailState>{
  EditVideoDetailBloc() : super(EditVideoDetailInitial()){
    on<EditVideoDetailRequest>(_onEditVideoDetailRequest);
  }

  Future<void> _onEditVideoDetailRequest(EditVideoDetailRequest event, Emitter<EditVideoDetailState> emit) async {
    try{

    }catch(e){
      emit(EditVideoDetailFailure(error: e.toString()));
    }
  }
}