import 'package:equatable/equatable.dart';

abstract class InviteFriendsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InviteFriendsInitial extends InviteFriendsState{}
class InviteFriendsLoading extends InviteFriendsState{}
class InviteFriendsSuccess extends InviteFriendsState{}
class InviteFriendsFailure extends InviteFriendsState{
  final String error;

  InviteFriendsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}