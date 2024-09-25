import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/your_shorts_model.dart';

abstract class YourShortsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class YourShortsInitial extends YourShortsState{}

class YourShortsLoading extends YourShortsState{}

class YourShortsLoaded extends YourShortsState{
  final List<YourShortsData> yourShortsData;
  final bool hasReachedMax;

  YourShortsLoaded({required this.yourShortsData, required this.hasReachedMax});

  @override
  List<Object?> get props => [yourShortsData, hasReachedMax];

}

class YourShortsFailure extends YourShortsState{
  final String error;

  YourShortsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}