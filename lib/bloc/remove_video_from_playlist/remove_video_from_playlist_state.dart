import 'package:equatable/equatable.dart';

abstract class RemoveVideoFromPlaylistState extends Equatable{
  @override
  List<Object?> get props => [];
}

class RemoveVideoFromPlaylistInitial extends RemoveVideoFromPlaylistState{}

class RemoveVideoFromPlaylistLoading extends RemoveVideoFromPlaylistState{}

class RemoveVideoFromPlaylistSuccess extends RemoveVideoFromPlaylistState{}

class RemoveVideoFromPlaylistFailure extends RemoveVideoFromPlaylistState{
  final String error;

  RemoveVideoFromPlaylistFailure({required this.error});

  @override
  List<Object?> get props => [];
}