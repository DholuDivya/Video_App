import 'package:equatable/equatable.dart';

abstract class RemoveVideoFromHistoryEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class RemoveVideoFromHistoryRequest extends RemoveVideoFromHistoryEvent{
  final List<int> videoIds;

  RemoveVideoFromHistoryRequest({required this.videoIds});

  @override
  List<Object?> get props => [];
}