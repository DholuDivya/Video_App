import 'package:equatable/equatable.dart';

abstract class GetShortsEvent extends Equatable{}

class GetShortsFromCamera extends GetShortsEvent{
  @override
  List<Object?> get props => [];
}

class GetShortsFromFile extends GetShortsEvent{
  @override
  List<Object?> get props => [];
}