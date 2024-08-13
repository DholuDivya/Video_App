import 'package:equatable/equatable.dart';

abstract class ViewIncrementEvent extends Equatable{}

class ViewIncrementRequest extends ViewIncrementEvent{
  final String videoSlug;

  ViewIncrementRequest({required this.videoSlug});

  @override
  List<Object?> get props => [];
}