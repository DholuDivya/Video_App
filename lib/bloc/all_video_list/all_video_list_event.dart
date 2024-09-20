import 'package:equatable/equatable.dart';

abstract class AllVideoListEvent extends Equatable{}

class GetAllVideoListEvent extends AllVideoListEvent{
  @override
  List<Object?> get props => [];
}

class LoadMoreVideoList extends AllVideoListEvent{
  @override
  List<Object?> get props => [];
}