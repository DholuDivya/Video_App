import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/search_suggestion_repo.dart';
import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_event.dart';
import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_state.dart';
import 'package:vimeo_clone/model/search_suggestion_model.dart';

class SearchSuggestionBloc
    extends Bloc<SearchSuggestionEvent, SearchSuggestionState> {
  SearchSuggestionBloc() : super(SearchSuggestionInitial()) {
    on<SearchSuggestionRequest>(_onSearchSuggestionRequest);
    on<ClearSearchSuggestions>(_onClearSearchSuggestion);
  }

  Future<void> _onSearchSuggestionRequest(SearchSuggestionRequest event,
      Emitter<SearchSuggestionState> emit) async {
    try {
      final List<SearchSuggestionModel>? searchSuggestionData =
          await SearchSuggestionRepo().getSearchSuggestion(event.searchQuery);
      print('++++++++++++++++++      $searchSuggestionData');
      emit(SearchSuggestionLoaded(searchSuggestionData: searchSuggestionData!));
    } catch (e) {
      emit(SearchSuggestionFailure(error: e.toString()));
    }
  }

  Future<void> _onClearSearchSuggestion(ClearSearchSuggestions event, Emitter<SearchSuggestionState> emit) async {
      emit(SearchSuggestionInitial());
  }
}
