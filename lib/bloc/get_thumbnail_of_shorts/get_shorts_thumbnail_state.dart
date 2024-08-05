import 'package:equatable/equatable.dart';

abstract class GetShortsThumbnailState extends Equatable{}

class GetShortsThumbnailInitial extends GetShortsThumbnailState{
  @override
  List<Object?> get props => [];
}

class GetShortsThumbnailLoading extends GetShortsThumbnailState{
  @override
  List<Object?> get props => [];
}

class GetShortsThumbnailSuccess extends GetShortsThumbnailState{
  @override
  List<Object?> get props => [];
}

class GetShortsThumbnailFailure extends GetShortsThumbnailState{
  final String error;

  GetShortsThumbnailFailure({required this.error});

  @override
  List<Object?> get props => [error];
}