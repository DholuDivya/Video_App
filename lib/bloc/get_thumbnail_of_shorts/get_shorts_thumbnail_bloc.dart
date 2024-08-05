import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_state.dart';

class GetShortsThumbnailBloc extends Bloc<GetShortsThumbnailEvent, GetShortsThumbnailState>{
  GetShortsThumbnailBloc() : super(GetShortsThumbnailInitial()) {
    on<GetShortsThumbnailRequest>(_onGetShortsThumbnailRequest);
  }

  Future<void> _onGetShortsThumbnailRequest(GetShortsThumbnailRequest event, Emitter<GetShortsThumbnailState> emit) async {
    try{
      
    }catch(e){

    }
  }

}