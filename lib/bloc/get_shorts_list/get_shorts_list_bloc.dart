import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_shorts_list_repo.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_state.dart';
import 'package:vimeo_clone/model/get_shorts_list_model.dart';

class GetShortsListBloc extends Bloc<GetShortsListEvent, GetShortsListState>{
  GetShortsListBloc() : super(GetShortsListInitial()){
    on<GetShortsListRequest>(_onGetShortsListRequest);
  }

  Future<void> _onGetShortsListRequest(GetShortsListRequest event, Emitter<GetShortsListState> emit) async {
    emit(GetShortsListLoading());
    try{
      final List<GetShortsListModel>? shortsData = await GetShortsListRepo().getShortsList();
      print('<<<<<<<<<<<<<<<<<<   $shortsData');
      emit(GetShortsListLoaded(shortsData: shortsData!));
    }catch(e){
      emit(GetShortsListFailure(error: e.toString()));
    }
  }

}