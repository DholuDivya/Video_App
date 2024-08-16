import 'package:equatable/equatable.dart';

abstract class CreatePlaylistState extends Equatable{}

class CreatePlaylistInitial extends CreatePlaylistState{
  @override
  List<Object?> get props => [];
}

class CreatePlaylistLoading extends CreatePlaylistState{
  @override
  List<Object?> get props => [];
}

class CreatePlaylistSuccess extends CreatePlaylistState{
  @override
  List<Object?> get props => [];
}

class CreatePlaylistFailure extends CreatePlaylistState{
  final String error;

  CreatePlaylistFailure({required this.error});

  @override
  List<Object?> get props => [error];
}