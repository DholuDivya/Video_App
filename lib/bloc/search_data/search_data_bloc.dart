import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/search_data_repo.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_event.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_state.dart';
import 'package:vimeo_clone/model/search_data_model.dart';

class SearchDataBloc extends Bloc<SearchDataEvent, SearchDataState>{
  SearchDataBloc() : super(SearchDataInitial()){
    on<SearchDataRequest>(_onSearchData);
  }

  Future<void> _onSearchData (SearchDataRequest event, Emitter<SearchDataState> emit) async {
    emit(SearchDataLoading());
    try{
      final List<SearchDataModel>? searchData = await SearchDataRepo().getSearchData(event.searchQuery);
      emit(SearchDataLoaded(searchData: searchData!));
    }catch(e){
      emit(SearchDataFailure(error: e.toString()));
    }
  }

}