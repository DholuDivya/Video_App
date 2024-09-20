import 'package:equatable/equatable.dart';

abstract class GetShortsListEvent extends Equatable{}

class GetShortsListRequest extends GetShortsListEvent{
  @override
  List<Object?> get props => [];
}

class GetShortsBySlugRequest extends GetShortsListEvent{
  final String shortsSlug;

  GetShortsBySlugRequest({required this.shortsSlug});

  @override
  List<Object?> get props => [shortsSlug];
}