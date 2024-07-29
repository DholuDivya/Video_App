import 'package:equatable/equatable.dart';

abstract class VideoListEvent extends Equatable {}

class GetVideoListEvent extends VideoListEvent {
  final int categoryId;

  GetVideoListEvent({required this.categoryId});

  @override
  List<Object?> get props => throw UnimplementedError();
}
