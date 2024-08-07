import 'package:equatable/equatable.dart';

abstract class GetVideoEvent extends Equatable{}

class OpenFilesToGetVideo extends GetVideoEvent{
  @override
  List<Object?> get props => [];
}