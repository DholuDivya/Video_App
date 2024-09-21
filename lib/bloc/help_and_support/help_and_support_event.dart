import 'package:equatable/equatable.dart';

abstract class HelpAndSupportEvent extends Equatable{}

class HelpAndSupportRequest extends HelpAndSupportEvent{
  final int userId;
  final String userEmail;
  final String helpMessage;
  final String subject;

  HelpAndSupportRequest({required this.userId, required this.userEmail, required this.helpMessage, required this.subject});

  @override
  List<Object?> get props => [userId, userEmail, helpMessage];
}