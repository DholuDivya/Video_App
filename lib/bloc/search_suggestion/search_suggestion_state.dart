import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/search_suggestion_model.dart';

abstract class SearchSuggestionState extends Equatable{}

class SearchSuggestionInitial extends SearchSuggestionState{
  @override
  List<Object?> get props => [];
}

class SearchSuggestionLoading extends SearchSuggestionState{
  @override
  List<Object?> get props => [];
}

class SearchSuggestionLoaded extends SearchSuggestionState{
  final List<SearchSuggestionModel> searchSuggestionData;

  SearchSuggestionLoaded({required this.searchSuggestionData});

  @override
  List<Object?> get props => [searchSuggestionData];
}

class SearchSuggestionFailure extends SearchSuggestionState{
  final String error;

  SearchSuggestionFailure({required this.error});

  @override
  List<Object?> get props => [error];
}