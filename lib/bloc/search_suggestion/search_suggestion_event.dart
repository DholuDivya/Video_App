import 'package:equatable/equatable.dart';

abstract class SearchSuggestionEvent extends Equatable{}

class SearchSuggestionRequest extends SearchSuggestionEvent{
  final String searchQuery;

  SearchSuggestionRequest({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}