import 'package:equatable/equatable.dart';

abstract class ShortsVisibleState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ShortsVisibleInitial extends ShortsVisibleState{}

class ShortsVisibleSuccess extends ShortsVisibleState{
  final String slug;
  final bool shortVisible;
  final int? index;

  ShortsVisibleSuccess({required this.slug, required this.shortVisible, this.index});

  @override
  List<Object?> get props => [slug, shortVisible, index];
}

class ShortsVisibleFailure extends ShortsVisibleState{
  final String error;

  ShortsVisibleFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
