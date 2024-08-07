import 'package:equatable/equatable.dart';

abstract class GetThumbnailEvent extends Equatable{}

class OpenFilesToGetThumbnail extends GetThumbnailEvent{
  @override
  List<Object?> get props => [];
}