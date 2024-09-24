import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/user_transaction_repo.dart';
import 'package:vimeo_clone/bloc/user_transaction/user_transaction_event.dart';
import 'package:vimeo_clone/bloc/user_transaction/user_transaction_state.dart';

import '../../model/user_transaction_model.dart';

class UserTransactionBloc extends Bloc<UserTransactionEvent, UserTransactionState>{

  int _offset = 0;
  final int _limit = 3;
  bool _hasReachedMax = false;

  UserTransactionBloc() : super(UserTransactionInitial()){
    on<UserTransactionRequest>(_onUserTransactionRequest);
    on<LoadMoreUserTransaction>(_onLoadMoreUserTransaction);
  }

  Future<void> _onUserTransactionRequest(UserTransactionRequest event, Emitter<UserTransactionState> emit) async {
    try{
      List<TransactionData>? transactionsList = [];
      _offset = 0;
      _hasReachedMax = false;
      Map<String, dynamic> transaction = await UserTransactionRepo().userTransaction(_limit, _offset);
      transactionsList = List<TransactionData>.from(transaction['data'].map((data) => TransactionData.fromJson(data)));
      _offset += _limit;
      _hasReachedMax = transactionsList.length < _limit;
      emit(UserTransactionLoaded(transactionData: transactionsList, hasReachedMax: _hasReachedMax));
    }catch(e){
      emit(UserTransactionFailure(error: e.toString()));
    }
  }


  Future<void> _onLoadMoreUserTransaction(LoadMoreUserTransaction event, Emitter<UserTransactionState> emit) async {
    if (state is UserTransactionLoaded && !_hasReachedMax) {
      try {
        List<TransactionData>? transactionsList = [];
        final currentState = state as UserTransactionLoaded;
        final updatedTransactionList = List<TransactionData>.from(currentState.transactionData);
        Map<String, dynamic> transaction = await UserTransactionRepo().userTransaction(_limit, _offset);
        transactionsList = List<TransactionData>.from(transaction['data'].map((data) => TransactionData.fromJson(data)));
        _offset += _limit;
        if(transactionsList.length < _limit){
          _hasReachedMax = true;
        }else{
          _hasReachedMax = false;
        }
        print('rgsdrhgusdrhsef $_hasReachedMax');
        updatedTransactionList.addAll(transactionsList);
        emit(UserTransactionLoaded(transactionData: updatedTransactionList, hasReachedMax: _hasReachedMax));
      } catch(e){}
    }
  }

}