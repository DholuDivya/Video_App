import 'package:equatable/equatable.dart';

abstract class AddVideoToPlaylistState extends Equatable{}

class AddVideoToPlaylistInitial extends AddVideoToPlaylistState{
  @override
  List<Object?> get props => [];
}

class AddVideoToPlaylistLoading extends AddVideoToPlaylistState{
  @override
  List<Object?> get props => [];
}

class AddVideoToPlaylistSuccess extends AddVideoToPlaylistState{
  @override
  List<Object?> get props => [];
}

class AddVideoToPlaylistFailure extends AddVideoToPlaylistState{
  final String error;

  AddVideoToPlaylistFailure({required this.error});

  @override
  List<Object?> get props => [error];
}