import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/get_shorts_list_model.dart';


abstract class GetShortsListState extends Equatable{}

class GetShortsListInitial extends GetShortsListState{
  @override
  List<Object?> get props => [];
}

class GetShortsListLoading extends GetShortsListState{
  @override
  List<Object?> get props => [];
}

class GetShortsListLoaded extends GetShortsListState{
  final List<ShortsListData> shortsList;
  final bool hasReachedMax;

  GetShortsListLoaded({required this.shortsList, required this.hasReachedMax});

  @override
  List<Object?> get props => [shortsList, hasReachedMax];
}

class GetShortsListFailure extends GetShortsListState{
  final String error;

  GetShortsListFailure({required this.error});

  @override
  List<Object?> get props => [error];
}



class GetShortsBySlugLoaded extends GetShortsListState{
  final List<GetShortsListModel> shortsData;

  GetShortsBySlugLoaded({required this.shortsData});

  @override
  List<Object?> get props => [shortsData];
}

class GetShortsBySlugFailure extends GetShortsListState{
  final String error;

  GetShortsBySlugFailure({required this.error});

  @override
  List<Object?> get props => [error];
}