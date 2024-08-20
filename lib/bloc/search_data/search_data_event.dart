import 'package:equatable/equatable.dart';

abstract class SearchDataEvent extends Equatable{}

class SearchDataRequest extends SearchDataEvent{
  final String searchQuery;

  SearchDataRequest({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}