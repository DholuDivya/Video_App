import 'package:equatable/equatable.dart';

abstract class GetAllChannelsEvent extends Equatable{}

class GetAllChannelsRequest extends GetAllChannelsEvent{
  @override
  List<Object?> get props => [];
}
