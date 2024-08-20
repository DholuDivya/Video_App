import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/search_data_model.dart';

abstract class SearchDataState extends Equatable{}

class SearchDataInitial extends SearchDataState{
  @override
  List<Object?> get props => [];
}

class SearchDataLoading extends SearchDataState{
  @override
  List<Object?> get props => [];
}

class SearchDataLoaded extends SearchDataState{
  final List<SearchDataModel> searchData;

  SearchDataLoaded({required this.searchData});

  @override
  List<Object?> get props => [searchData];
}

class SearchDataFailure extends SearchDataState{
  final String error;

  SearchDataFailure({required this.error});

  @override
  List<Object?> get props => [error];
}