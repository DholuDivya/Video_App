import 'package:equatable/equatable.dart';

abstract class PlayVideoEvent extends Equatable{}

class GetVideoSlugEvent extends PlayVideoEvent{
  final String slug;

  GetVideoSlugEvent({required this.slug});

  @override
  List<Object?> get props => [slug];
}