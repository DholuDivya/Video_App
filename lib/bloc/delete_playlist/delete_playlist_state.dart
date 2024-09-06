import 'package:equatable/equatable.dart';

abstract class DeletePlaylistState extends Equatable{
  @override
  List<Object?> get props => [];
}

class DeletePlaylistInitial extends DeletePlaylistState{}

class DeletePlaylistLoading extends DeletePlaylistState{}

class DeletePlaylistSuccess extends DeletePlaylistState{}

class DeletePlaylistFailure extends DeletePlaylistState{
  final String error;

  DeletePlaylistFailure({required this.error});

  @override
  List<Object?> get props => [error];
}