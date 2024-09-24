import 'package:equatable/equatable.dart';
import 'package:vimeo_clone/model/user_transaction_model.dart';

abstract class UserTransactionState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UserTransactionInitial extends UserTransactionState{}

class UserTransactionLoading extends UserTransactionState{}

class UserTransactionLoaded extends UserTransactionState{
  final List<TransactionData> transactionData;
  final bool hasReachedMax;

  UserTransactionLoaded({required this.transactionData, required this.hasReachedMax});

  @override
  List<Object?> get props => [transactionData, hasReachedMax];
}

class UserTransactionFailure extends UserTransactionState{
  final String error;

  UserTransactionFailure({required this.error});

  @override
  List<Object?> get props => [error];
}