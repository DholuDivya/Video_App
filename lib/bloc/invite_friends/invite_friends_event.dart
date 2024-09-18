import 'package:equatable/equatable.dart';

abstract class InviteFriendsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class InviteFriendsRequest extends InviteFriendsEvent{}