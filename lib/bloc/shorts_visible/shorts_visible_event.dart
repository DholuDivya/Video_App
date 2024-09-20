import 'package:equatable/equatable.dart';

abstract class ShortsVisibleEvent extends Equatable{}

class ShortsVisibleRequest extends ShortsVisibleEvent{
  final String slug;
  final int? index;
  final bool? shortVisible;

  ShortsVisibleRequest({required this.slug, this.index , this.shortVisible});

  @override
  List<Object?> get props => [slug];
}