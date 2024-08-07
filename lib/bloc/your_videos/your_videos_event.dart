import 'package:equatable/equatable.dart';

abstract class YourVideosEvent extends Equatable{}

class GetYourVideosEvent extends YourVideosEvent{
  @override
  List<Object?> get props => [];
}