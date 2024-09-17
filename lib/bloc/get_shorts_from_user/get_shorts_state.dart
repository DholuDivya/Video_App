import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

abstract class GetShortsState extends Equatable{}

class GetShortsInitial extends GetShortsState{
  @override
  List<Object?> get props => [];
}

class GetShortsLoading extends GetShortsState{
  @override
  List<Object?> get props => [];
}


class GetShortsSuccess extends GetShortsState{
  final PlatformFile userShorts;

  GetShortsSuccess({required this.userShorts});

  @override
  List<Object?> get props => [userShorts];
}

class GetShortsFailure extends GetShortsState{
  final String error;

  GetShortsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}