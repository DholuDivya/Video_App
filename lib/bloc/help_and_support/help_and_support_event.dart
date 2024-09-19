import 'package:equatable/equatable.dart';

abstract class HelpAndSupportEvent extends Equatable{}

class HelpAndSupportRequest extends HelpAndSupportEvent{
  final int userId;
  final String userEmail;
  final String helpMessage;

  HelpAndSupportRequest({required this.userId, required this.userEmail, required this.helpMessage});

  @override
  List<Object?> get props => [userId, userEmail, helpMessage];
}