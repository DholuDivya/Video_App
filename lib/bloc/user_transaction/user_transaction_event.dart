import 'package:equatable/equatable.dart';

abstract class UserTransactionEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UserTransactionRequest extends UserTransactionEvent{}

class LoadMoreUserTransaction extends UserTransactionEvent{}
